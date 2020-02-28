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
    
    var api = API()
    
    var book: Book = Biblia.books[0]
    @Published var chapter: Int = 1
    @Published var versek = [Versek]()
    @Published var isLoading = false
    @Published var translation = Translation.RUF
    @Published var error: BibleError?
        
    @Published var yellows = [Versek]()
    @Published var reds = [Versek]()
    @Published var blues = [Versek]()
    @Published var greens = [Versek]()
    @Published var grays = [Versek]()
    
    var colors = ["Yellow", "Red", "Blue", "Green", "Gray"]
    
    var fileService = FileService()

    var cancellables = Set<AnyCancellable>()
    
    init() {
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
        loadFiles()
    }
    
    func markVers(_ vers: Versek, color: String) {
        self.removeVersMarkingFromAll(vers: vers)
        switch color {
        case "Yellow":
            self.yellows.append(vers)
        case "Red":
            self.reds.append(vers)
        case "Blue":
            self.blues.append(vers)
        case "Green":
            self.greens.append(vers)
        case "Gray":
            self.grays.append(vers)
        default:
            break
        }
        saveFiles()
    }
    
   private func removeVersMarkingFromAll(vers: Versek) {
        self.yellows.removeAll(where: {$0.hely.gepi == vers.hely.gepi})
        self.reds.removeAll(where: {$0.hely.gepi == vers.hely.gepi})
        self.blues.removeAll(where: {$0.hely.gepi == vers.hely.gepi})
        self.greens.removeAll(where: {$0.hely.gepi == vers.hely.gepi})
        self.grays.removeAll(where: {$0.hely.gepi == vers.hely.gepi})
    }
    
    func removeVersMarking(vers: Versek) {
        self.removeVersMarkingFromAll(vers: vers)
        saveFiles()
    }
    
    func saveFiles() {
        fileService.saveFiles(lists: [self.yellows, self.reds, self.blues, self.greens, self.grays])
    }
    
    func loadFiles() {
        let lists = fileService.loadFiles()
        self.yellows = lists[0]
        self.reds = lists[1]
        self.blues = lists[2]
        self.greens = lists[3]
        self.grays = lists[4]
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
    
}
    
