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
    
