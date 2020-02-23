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
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        $chapter
            .sink (receiveValue: { ch in
                self.fetchChapter(forBook: self.book, andChapter: ch, translation: self.translation)
            })
            .store(in: &cancellables)
        
        $translation
            .sink (receiveValue: { tr in
                self.fetchChapter(forBook: self.book, andChapter: self.chapter, translation: tr)
            })
            .store(in: &cancellables)
        
    }
    
    func fetchChapter(forBook book: Book, andChapter chapter: Int, translation: Translation) {
        isLoading = true
        api.fetch(forBook: book.abbreviation, and: chapter, translation: translation.rawValue)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure( _):
                    self.isLoading = false
                    self.versek = []
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
    
