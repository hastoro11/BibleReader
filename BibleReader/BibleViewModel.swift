//
//  ChapterViewModel.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import Combine

class BibleViewModel: ObservableObject {
    
    // MARK: - Services
    var api = API()
    var fileService = FileService()
    var userSettingService = UserSettingsService()
    
    // MARK: - Reader Properties
    @Published var book: Book = Biblia.books[0] {
        didSet {
            userSettingService.setBook(book)
        }
    }
    @Published var chapter: Int = 1 {
        didSet {
            userSettingService.setChapter(chapter)
        }
    }
    @Published var versek = [Versek]()
    @Published var isLoading = false
    @Published var translation = Translation.RUF {
        didSet {
            userSettingService.setTranslation(translation)
        }
    }
    
    // MARK: - Error
    @Published var error: BibleError?
        
    // MARK: - Favorites
    @Published var favorites = Array(repeating: [Favorite](), count: 5)
    
    // MARK: - App settings
    @Published var saveLastPosition: Bool {
        didSet {
            userSettingService.setSaveLastPosition(saveLastPosition)
        }
    }
    
    var colors = ["Yellow", "Red", "Blue", "Green", "Gray"]
    @Published var titles: [String]
    
    // MARK: - Cancellables
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        saveLastPosition = userSettingService.getSaveLastPosition()
        titles = userSettingService.getTitles()
        $chapter
            .sink (receiveValue: { ch in
                self.fetchChapter(forBook: self.book, andChapter: ch, translation: self.translation)
            })
            .store(in: &cancellables)
        
        $translation
            .sink (receiveValue: { tr in
                if self.checkTranslationAndBook(tr: tr, book: self.book) {
                    self.fetchChapter(forBook: self.book, andChapter: self.chapter, translation: tr)
                } else {
                    self.error = BibleError.translating(self.book.name)
                    self.versek = []
                }
            })
            .store(in: &cancellables)
        
        $titles
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink(receiveValue: {value in
                self.userSettingService.setTitles(value)
            })
            .store(in: &cancellables)
        
        loadFiles()
        
        
        if saveLastPosition {
            self.translation = userSettingService.getTranslation()
            self.book = userSettingService.getBook()
            self.chapter = userSettingService.getChapter()
            self.fetchChapter(forBook: self.book, andChapter: self.chapter, translation: self.translation)
        }
    }
    
    // MARK: - Marking
    func markVers(_ vers: Versek, index: Int) {
        self.removeVersMarkingFromAll(vers)
        let favorite = Favorite(vers: vers, book: self.book.abbreviation, chapter: self.chapter, forditas: self.translation.rawValue)
        
        self.favorites[index].append(favorite)
        
        saveFiles()
    }
    
    private func removeVersMarkingFromAll(_ vers: Versek) {
        for index in self.favorites.indices {
            self.favorites[index] = self.favorites[index].filter({$0.vers.hely.szep != vers.hely.szep})
        }
    }
    
    func removeVersMarking(_ vers: Versek) {
        self.removeVersMarkingFromAll(vers)
        saveFiles()
    }
    
    func saveFiles() {
        fileService.saveFiles(self.favorites)
    }
    
    func loadFiles() {
        self.favorites = fileService.loadFiles()
    }
    
    private func checkTranslationAndBook(tr: Translation, book: Book) -> Bool {
        if (translation == .KG || translation == .RUF) && (tr == .KNB || tr == .SZIT) {
            
            if let index = Biblia.protestant.firstIndex(of: book.abbreviation) {
                let name = Biblia.catholic[index]
                let book = Biblia.catholicBooks.first(where: {$0.abbreviation == name})
                if let book = book {
                    self.book = book
                    return true
                } else {
                    return false
                }
            }
        } else if (translation == .KNB || translation == .SZIT) && (tr == .KG || tr == .RUF) {
            
            if let index = Biblia.catholic.firstIndex(of: book.abbreviation) {
                let name = Biblia.protestant[index]
                let book = Biblia.books.first(where: {$0.abbreviation == name})
                if let book = book {
                    self.book = book
                    return true
                } else {
                    return false
                }
            }
        } 
        return true
    }

    // MARK: - Fetching
    func fetchChapter(forBook book: Book, andChapter chapter: Int, translation: Translation) {
        isLoading = true
        
        api.fetch(forBook: book, and: chapter, translation: translation.rawValue)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure(let error):
                    self.isLoading = false
                    self.versek = []
                    self.error = error
                default:
                    break
                }
            }, receiveValue: {response in
                self.isLoading = false
                self.versek = response.valasz.versek
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Jump to chapter
    func jumpToChapter(_ favorite: Favorite) {
         
        guard let translation = Translation(rawValue: favorite.forditas) else {
            fatalError("Error getting translation from favorite")
        }
        self.translation = translation
        self.book = getBookFromName(favorite.book, translationName: favorite.forditas)
        self.chapter = favorite.chapter
        
        
//        let szep = favorite.vers.hely.szep
//        let pattern = #"(\w+)\s+(\d+),\d+"#
//        guard let regex = try? NSRegularExpression(pattern: pattern, options: []),
//            let matches = regex.firstMatch(in: szep, options: [], range: NSRange(location: 0, length: szep.utf16.count))else {return}
//        if let bookRange = Range(matches.range(at: 1), in: szep) {
//            let bookName = String(szep[bookRange])
//            if let book = self.getBookFromName(bookName, translationName: favorite.forditas) {
//                self.book = book
//            }
//        }
//        if let chapterRange = Range(matches.range(at: 2), in: szep), let chapter = Int(szep[chapterRange]), let translation = Translation(rawValue: favorite.forditas) {
//            self.translation = translation
//            self.chapter = chapter
//        }
    }
    
    private func getBookFromName(_ name: String, translationName: String) -> Book {
        guard let translation = Translation(rawValue: translationName) else {
            fatalError("Error getting translation from saved vers")
        }
        if translation == .KG || translation == .RUF {
            return Biblia.books.first(where: {$0.abbreviation == name})!
        } else {
            return Biblia.catholicBooks.first(where: {$0.abbreviation == name})!
        }
    }
    
    // MARK: - Delete favorite
    func deleteFavorite(_ favorite: Favorite) {
        for index in colors.indices {
            favorites[index].removeAll(where: {$0.vers.hely.gepi == favorite.vers.hely.gepi})
        }
        saveFiles()
    }
}
    
