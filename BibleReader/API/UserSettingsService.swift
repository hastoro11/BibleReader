//
//  UserSettingsService.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 29..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

let kSaveLastPosition = "kSaveLastPosition"
let kTranslation = "kTranslation"
let kBook = "kBook"
let kChapter = "kChapter"

class UserSettingsService {
    
    func setSaveLastPosition(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: kSaveLastPosition)
    }
    
    func getSaveLastPosition() -> Bool {
        UserDefaults.standard.bool(forKey: kSaveLastPosition)
    }
    
    func setTranslation(_ value: Translation) {
        UserDefaults.standard.set(value.rawValue, forKey: kTranslation)
    }
    
    func getTranslation() -> Translation {
        let value = UserDefaults.standard.string(forKey: kTranslation) ?? "RUF"
        return Translation(rawValue: value) ?? .RUF
    }
    
    func setBook(_ value: Book) {
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: kBook)
        } catch {
            fatalError("Error converting book: \(value.name)")
        }
    }
    
    func getBook() -> Book {
        let translation = self.getTranslation()
        let defaultBook = translation == .RUF || translation == .KG ? Biblia.books[0] : Biblia.catholicBooks[0]
        if let data = UserDefaults.standard.object(forKey: kBook) as? Data {
            do {
                let book = try JSONDecoder().decode(Book.self, from: data)
                return book
            } catch {
                fatalError("Error getting book from UserDefaults")                
            }
        }
        return defaultBook
    }
    
    func setChapter(_ value: Int) {
        UserDefaults.standard.set(value, forKey: kChapter)
    }
    
    func getChapter() -> Int {
        let chapter = UserDefaults.standard.integer(forKey: kChapter)
        return chapter == 0 ? 1 : chapter
    }
}
