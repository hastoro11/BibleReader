//
//  Biblia.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 07..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

enum Covenant {
    case old, new
}

struct Book: Identifiable {
    var index: Int
    var covenant: Covenant
    var name: String
    var shortName: String
    var abbreviation: String
    var chapters: Int
    
    var id: Int {
        return index
    }
}

struct Biblia_RUF {
    static var books: [Book] = [
        Book(index: 0, covenant: .old, name: "Mózes 1. könyve", shortName: "1Mózes", abbreviation: "1Móz",  chapters: 50),
        Book(index: 1, covenant: .old, name: "Mózes 2. könyve", shortName: "2Mózes", abbreviation: "2Móz", chapters: 40),
        Book(index: 2, covenant: .old, name: "Mózes 3. könyve", shortName: "3Mózes", abbreviation: "3Móz", chapters: 27),
        Book(index: 3, covenant: .old, name: "Mózes 4. könyve", shortName: "4Mózes", abbreviation: "4Móz", chapters: 36),
        Book(index: 4, covenant: .old, name: "Mózes 5. könyve", shortName: "5Mózes", abbreviation: "5Móz", chapters: 34),
        Book(index: 5, covenant: .old, name: "Józsué könyve", shortName: "Józsue", abbreviation: "Józs", chapters: 24),
        Book(index: 6, covenant: .old, name: "Bírák könyve", shortName: "Bírák", abbreviation: "Bírák", chapters: 21),
        Book(index: 7, covenant: .old, name: "Ruth könyve", shortName: "Ruth", abbreviation: "Ruth", chapters: 4),
        Book(index: 8, covenant: .old, name: "Sámuel 1. könyve", shortName: "1Sámuel", abbreviation: "1Sám", chapters: 31),
        Book(index: 9, covenant: .old, name: "Sámuel 2. könyve", shortName: "2Sámuel", abbreviation: "2Sám", chapters: 24),
        Book(index: 10, covenant: .old, name: "Királyok 1. könyve", shortName: "1Kir", abbreviation: "1Kir", chapters: 22),
        Book(index: 11, covenant: .old, name: "Királyok 2. könyve", shortName: "2Kir", abbreviation: "2Kir", chapters: 25),
        Book(index: 12, covenant: .old, name: "Krónikák 1. könyve", shortName: "1Krón", abbreviation: "1Krón", chapters: 29),
        Book(index: 13, covenant: .old, name: "Krónikák 2. könyve", shortName: "2Krón", abbreviation: "2Krón", chapters: 36),
        Book(index: 14, covenant: .old, name: "Ezsdrás könyve", shortName: "Ezsdrás", abbreviation: "Ezsdr", chapters: 10),
        Book(index: 15, covenant: .old, name: "Nehémiás könyve", shortName: "Nehémiás", abbreviation: "Neh", chapters: 13),
        Book(index: 16, covenant: .old, name: "Eszter könyve", shortName: "Eszter", abbreviation: "Eszt", chapters: 10),
        Book(index: 17, covenant: .old, name: "Jób könyve", shortName: "Jób", abbreviation: "Jób", chapters: 42),
        Book(index: 18, covenant: .old, name: "Zsoltárok könyve", shortName: "Zsoltárok", abbreviation: "Zsolt", chapters: 150),
        Book(index: 19, covenant: .old, name: "Példabeszédek könyve", shortName: "Példabeszédek", abbreviation: "Péld", chapters: 31),
        Book(index: 20, covenant: .old, name: "Prédikátor könyve", shortName: "Prédikátor", abbreviation: "Préd", chapters: 12),
        Book(index: 21, covenant: .old, name: "Énekek éneke", shortName: "Énekek", abbreviation: "Énekek", chapters: 8),
        Book(index: 22, covenant: .old, name: "Ézsaiás könyve", shortName: "Ézsaiás", abbreviation: "Ézs", chapters: 66),
        Book(index: 23, covenant: .old, name: "Jeremiás könyve", shortName: "Jeremiás", abbreviation: "Jer", chapters: 52),
        Book(index: 24, covenant: .old, name: "Jeremiás siralmai", shortName: "JerSir", abbreviation: "JSir", chapters: 5),
        Book(index: 25, covenant: .old, name: "Ezékiel könyve", shortName: "Ezékiel", abbreviation: "Ez", chapters: 48),
        Book(index: 26, covenant: .old, name: "Dániel könyve", shortName: "Dániel", abbreviation: "Dán", chapters: 12),
        Book(index: 27, covenant: .old, name: "Hóseás könyve", shortName: "Hóseás", abbreviation: "Hós", chapters: 14),
        Book(index: 28, covenant: .old, name: "Jóel könyve", shortName: "Jóel", abbreviation: "Jóel", chapters: 4),
        Book(index: 29, covenant: .old, name: "Ámósz könyve", shortName: "Ámosz", abbreviation: "Ám", chapters: 9),
        Book(index: 30, covenant: .old, name: "Abdiás könyve", shortName: "Abdiás", abbreviation: "Abd", chapters: 1),
        Book(index: 31, covenant: .old, name: "Jónás könyve", shortName: "Jónás", abbreviation: "Jón", chapters: 4),
        Book(index: 32, covenant: .old, name: "Mikeás könyve", shortName: "Mikeás", abbreviation: "Mik", chapters: 7),
        Book(index: 33, covenant: .old, name: "Náhum könyve", shortName: "Náhum", abbreviation: "Náh", chapters: 3),
        Book(index: 34, covenant: .old, name: "Habakuk könyve", shortName: "Habakuk", abbreviation: "Hab", chapters: 3),
        Book(index: 35, covenant: .old, name: "Zofóniás könyve", shortName: "Zofóniás", abbreviation: "Zof", chapters: 3),
        Book(index: 36, covenant: .old, name: "Haggeus könyve", shortName: "Haggeus", abbreviation: "Hag", chapters: 2),
        Book(index: 37, covenant: .old, name: "Zakariás könyve", shortName: "Zakariás", abbreviation: "Zak", chapters: 14),
        Book(index: 38, covenant: .old, name: "Malakiás könyve", shortName: "Malakiás", abbreviation: "Mal", chapters: 3),
        Book(index: 0, covenant: .new, name: "Máté evangéliuma", shortName: "Máté", abbreviation: "Máté", chapters: 28),
        Book(index: 1, covenant: .new, name: "Márk evangéliuma", shortName: "Márk", abbreviation: "Márk", chapters: 16),
        Book(index: 2, covenant: .new, name: "Lukács evangéliuma", shortName: "Lukács", abbreviation: "Luk", chapters: 24),
        Book(index: 3, covenant: .new, name: "János evangéliuma", shortName: "János", abbreviation: "Ján", chapters: 21),
        Book(index: 4, covenant: .new, name: "Az apostolok cselekedetei", shortName: "ApCsel", abbreviation: "ApCsel", chapters: 28),
        Book(index: 5, covenant: .new, name: "Pál levele a rómaiakhoz", shortName: "Róma", abbreviation: "Róm", chapters: 16),
        Book(index: 6, covenant: .new, name: "Pál 1. levele a korinthusiakhoz", shortName: "1Kor", abbreviation: "1Kor", chapters: 16),
        Book(index: 7, covenant: .new, name: "Pál 2. levele a korinthusiakhoz", shortName: "2Kor", abbreviation: "2Kor", chapters: 13),
        Book(index: 8, covenant: .new, name: "Pál levele a galátákhoz", shortName: "Galáta", abbreviation: "Gal", chapters: 6),
        Book(index: 9, covenant: .new, name: "Pál levele a efezusiakhoz", shortName: "Efezus", abbreviation: "Ef", chapters: 6),
        Book(index: 10, covenant: .new, name: "Pál levele a filippiekhez", shortName: "Filippi", abbreviation: "Fil", chapters: 4),
        Book(index: 11, covenant: .new, name: "Pál levele a kolosséiakhoz", shortName: "Kolossé", abbreviation: "Kol", chapters: 4),
        Book(index: 12, covenant: .new, name: "Pál 1. levele a thesszalonikaiakhoz", shortName: "1Thessz", abbreviation: "1Thessz", chapters: 5),
        Book(index: 13, covenant: .new, name: "Pál 2. levele a thesszalonikaiakhoz", shortName: "2Thessz", abbreviation: "2Thessz", chapters: 3),
        Book(index: 14, covenant: .new, name: "Pál 1. levele Timóteushoz", shortName: "1Tim", abbreviation: "1Tim", chapters: 6),
        Book(index: 15, covenant: .new, name: "Pál 2. levele Timóteushoz", shortName: "2Tim", abbreviation: "2Tim", chapters: 4),
        Book(index: 16, covenant: .new, name: "Pál levele Tituszhoz", shortName: "Titusz", abbreviation: "Tit", chapters: 3),
        Book(index: 17, covenant: .new, name: "Pál levele Filemonhoz", shortName: "Filemon", abbreviation: "Filem", chapters: 1),
        Book(index: 18, covenant: .new, name: "A zsidókhoz írt levél", shortName: "Zsidók", abbreviation: "Zsid", chapters: 13),
        Book(index: 19, covenant: .new, name: "Jakab levele", shortName: "Jakab", abbreviation: "Jak", chapters: 5),
        Book(index: 20, covenant: .new, name: "Péter 1. levele", shortName: "1Péter", abbreviation: "1Pt", chapters: 5),
        Book(index: 21, covenant: .new, name: "Péter 2. levele", shortName: "2Péter", abbreviation: "2Pt", chapters: 3),
        Book(index: 22, covenant: .new, name: "János 1. levele", shortName: "1János", abbreviation: "1Jn", chapters: 5),
        Book(index: 23, covenant: .new, name: "János 2. levele", shortName: "2János", abbreviation: "2Jn", chapters: 1),
        Book(index: 24, covenant: .new, name: "János 3. levele", shortName: "3János", abbreviation: "3Jn", chapters: 1),
        Book(index: 25, covenant: .new, name: "Júdás levele", shortName: "Júdás", abbreviation: "Júd", chapters: 1),
        Book(index: 26, covenant: .new, name: "Jelenések könyve", shortName: "Jelenések", abbreviation: "Jel", chapters: 22),
    ]
    
    static func index(_ book: Book) -> Int {
        let i = books.firstIndex(where: {$0.name == book.name})!
        return i
    }
}



        
