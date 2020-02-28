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
    
    @Published var favorites = [Versek]()
    @Published var yellows = [Versek]()
    @Published var reds = [Versek]()
    @Published var blues = [Versek]()
    @Published var greens = [Versek]()
    @Published var grays = [Versek]()
    
    var colors = ["Yellow", "Red", "Blue", "Green", "Gray"]

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
        
    }
    
    func addVersToFavorites(vers: Versek, color: String) {
        self.removeVersFromAll(vers: vers)
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
    }
    
    private func removeVersFromAll(vers: Versek) {
        self.yellows.removeAll(where: {$0.hely.gepi == vers.hely.gepi})
        self.reds.removeAll(where: {$0.hely.gepi == vers.hely.gepi})
        self.blues.removeAll(where: {$0.hely.gepi == vers.hely.gepi})
        self.greens.removeAll(where: {$0.hely.gepi == vers.hely.gepi})
        self.grays.removeAll(where: {$0.hely.gepi == vers.hely.gepi})
    }
    
    func saveFiles() {
        for color in colors {
            guard let fileUrl = self.getUrl(forFile: color) else {return}
            var data = Data()
            do {
                switch color {
                case "Yellow":
                    data = try JSONEncoder().encode(self.yellows)
                case "Red":
                    data = try JSONEncoder().encode(self.reds)
                case "Blue":
                    data = try JSONEncoder().encode(self.blues)
                case "Green":
                    data = try JSONEncoder().encode(self.greens)
                case "Gray":
                    data = try JSONEncoder().encode(self.grays)
                default:
                    break
                }
                try data.write(to: fileUrl)
            } catch {
                fatalError("Error loading: \(error.localizedDescription)")
            }
        }
    }
    
    func loadFiles() {
        for color in colors {
            guard let fileUrl = self.getUrl(forFile: color) else {return}
            do {
                let data = try Data(contentsOf: fileUrl)
                if !data.isEmpty {
                    let versek = try JSONDecoder().decode([Versek].self, from: data)
                    switch color {
                    case "Yellow":
                        self.yellows = versek
                    case "Red":
                        self.reds = versek
                    case "Blue":
                        self.blues = versek
                    case "Green":
                        self.greens = versek
                    case "Gray":
                        self.grays = versek
                    default:
                        break
                    }
                }
            } catch {
                fatalError("Error loading: \(error.localizedDescription)")
            }
        }
        
    }
    
    private func getUrl(forFile file: String) -> URL? {
        
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documents)
        let fileUrl = documents
            .appendingPathComponent(file.capitalized)
            .appendingPathExtension("json")
        
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
        }
        
        return fileUrl
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
    
