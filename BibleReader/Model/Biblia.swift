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

struct Book {
    var index: Int
    var covenant: Covenant
    var name: String
    var shortName: String
    var search: String
    var chapters: Int
}

struct Biblia_RUF {
    static var books: [Book] = [
        Book(index: 0, covenant: .old, name: "Mózes 1. könyve", shortName: "1Mózes", search: "Ter", chapters: 50),
        Book(index: 1, covenant: .old, name: "Mózes 2. könyve", shortName: "2Mózes", search: "Kiv", chapters: 40),
        Book(index: 2, covenant: .old, name: "Mózes 3. könyve", shortName: "3Mózes", search: "Lev", chapters: 27),
        Book(index: 3, covenant: .old, name: "Mózes 4. könyve", shortName: "4Mózes", search: "Szam", chapters: 36),
        Book(index: 4, covenant: .old, name: "Mózes 5. könyve", shortName: "5Mózes", search: "MTorv", chapters: 34),
        Book(index: 5, covenant: .old, name: "Józsué könyve", shortName: "Józsue", search: "Jozs", chapters: 24),
        Book(index: 6, covenant: .old, name: "Bírák könyve", shortName: "Bírák", search: "Bir", chapters: 21),
        Book(index: 7, covenant: .old, name: "Ruth könyve", shortName: "Ruth", search: "Rut", chapters: 4),
        Book(index: 8, covenant: .old, name: "Sámuel 1. könyve", shortName: "1Sámuel", search: "1Sam", chapters: 31),
        Book(index: 9, covenant: .old, name: "Sámuel 2. könyve", shortName: "2Sámuel", search: "2Sam", chapters: 24),
        Book(index: 10, covenant: .old, name: "Királyok 1. könyve", shortName: "1Kir", search: "1Kir", chapters: 22),
        Book(index: 11, covenant: .old, name: "Királyok 2. könyve", shortName: "2Kir", search: "2Kir", chapters: 25),
        Book(index: 12, covenant: .old, name: "Krónikák 1. könyve", shortName: "1Krón", search: "1Kron", chapters: 29),
        Book(index: 13, covenant: .old, name: "Krónikák 2. könyve", shortName: "2Krón", search: "2Kron", chapters: 36),
        Book(index: 14, covenant: .old, name: "Ezsdrás könyve", shortName: "Ezsdrás", search: "Ezdr", chapters: 10),
        Book(index: 15, covenant: .old, name: "Nehémiás könyve", shortName: "Nehémiás", search: "Neh", chapters: 13),
        Book(index: 16, covenant: .old, name: "Eszter könyve", shortName: "Eszter", search: "Eszt", chapters: 10),
        Book(index: 17, covenant: .old, name: "Jób könyve", shortName: "Jób", search: "Job", chapters: 42),
        Book(index: 18, covenant: .old, name: "Zsoltárok könyve", shortName: "Zsoltárok", search: "Zsolt", chapters: 150),
        Book(index: 19, covenant: .old, name: "Példabeszédek könyve", shortName: "Példabeszédek", search: "Peld", chapters: 31),
        Book(index: 20, covenant: .old, name: "Prédikátor könyve", shortName: "Prédikátor", search: "Pred", chapters: 12),
        Book(index: 21, covenant: .old, name: "Énekek éneke", shortName: "Énekek", search: "En", chapters: 8),
        Book(index: 22, covenant: .old, name: "Ézsaiás könyve", shortName: "Ézsaiás", search: "Iz", chapters: 66),
        Book(index: 23, covenant: .old, name: "Jeremiás könyve", shortName: "Jeremiás", search: "Jer", chapters: 52),
        Book(index: 24, covenant: .old, name: "Jeremiás siralmai", shortName: "JerSir", search: "Siralm", chapters: 5),
        Book(index: 25, covenant: .old, name: "Ezékiel könyve", shortName: "Ezékiel", search: "Ez", chapters: 48),
        Book(index: 26, covenant: .old, name: "Dániel könyve", shortName: "Dániel", search: "Dan", chapters: 12),
        Book(index: 27, covenant: .old, name: "Hóseás könyve", shortName: "Hóseás", search: "Oz", chapters: 14),
        Book(index: 28, covenant: .old, name: "Jóel könyve", shortName: "Jóel", search: "Jo", chapters: 4),
        Book(index: 29, covenant: .old, name: "Ámósz könyve", shortName: "Ámosz", search: "Am", chapters: 9),
        Book(index: 30, covenant: .old, name: "Abdiás könyve", shortName: "Abdiás", search: "Abd", chapters: 1),
        Book(index: 31, covenant: .old, name: "Jónás könyve", shortName: "Jónás", search: "Jon", chapters: 4),
        Book(index: 32, covenant: .old, name: "Mikeás könyve", shortName: "Mikeás", search: "Mik", chapters: 7),
        Book(index: 33, covenant: .old, name: "Náhum könyve", shortName: "Náhum", search: "Nah", chapters: 3),
        Book(index: 34, covenant: .old, name: "Habakuk könyve", shortName: "Habakuk", search: "Hab", chapters: 3),
        Book(index: 35, covenant: .old, name: "Zofóniás könyve", shortName: "Zofóniás", search: "Szof", chapters: 3),
        Book(index: 36, covenant: .old, name: "Haggeus könyve", shortName: "Haggeus", search: "Agg", chapters: 2),
        Book(index: 37, covenant: .old, name: "Zakariás könyve", shortName: "Zakariás", search: "Zak", chapters: 14),
        Book(index: 38, covenant: .old, name: "Malakiás könyve", shortName: "Malakiás", search: "Mal", chapters: 3),
        Book(index: 0, covenant: .new, name: "Máté evangéliuma", shortName: "Máté", search: "Mt", chapters: 28),
        Book(index: 1, covenant: .new, name: "Márk evangéliuma", shortName: "Márk", search: "Mk", chapters: 16),
        Book(index: 2, covenant: .new, name: "Lukács evangéliuma", shortName: "Lukács", search: "Lk", chapters: 24),
        Book(index: 3, covenant: .new, name: "János evangéliuma", shortName: "János", search: "Jn", chapters: 21),
        Book(index: 4, covenant: .new, name: "Az apostolok cselekedetei", shortName: "ApCsel", search: "Csel", chapters: 28),
        Book(index: 5, covenant: .new, name: "Pál levele a rómaiakhoz", shortName: "Róma", search: "Rom", chapters: 16),
        Book(index: 6, covenant: .new, name: "Pál 1. levele a korinthusiakhoz", shortName: "1Kor", search: "1Kor", chapters: 16),
        Book(index: 7, covenant: .new, name: "Pál 2. levele a korinthusiakhoz", shortName: "2Kor", search: "2Kor", chapters: 13),
        Book(index: 8, covenant: .new, name: "Pál levele a galátákhoz", shortName: "Galáta", search: "Gal", chapters: 6),
        Book(index: 9, covenant: .new, name: "Pál levele a efezusiakhoz", shortName: "Efezus", search: "Ef", chapters: 6),
        Book(index: 10, covenant: .new, name: "Pál levele a filippiekhez", shortName: "Filippi", search: "Fil", chapters: 4),
        Book(index: 11, covenant: .new, name: "Pál levele a kolosséiakhoz", shortName: "Kolossé", search: "Kol", chapters: 4),
        Book(index: 12, covenant: .new, name: "Pál 1. levele a thesszalonikaiakhoz", shortName: "1Thessz", search: "1Tessz", chapters: 5),
        Book(index: 13, covenant: .new, name: "Pál 2. levele a thesszalonikaiakhoz", shortName: "2Thessz", search: "2Tessz", chapters: 3),
        Book(index: 14, covenant: .new, name: "Pál 1. levele Timóteushoz", shortName: "1Tim", search: "1Tim", chapters: 6),
        Book(index: 15, covenant: .new, name: "Pál 2. levele Timóteushoz", shortName: "2Tim", search: "2Tim", chapters: 4),
        Book(index: 16, covenant: .new, name: "Pál levele Tituszhoz", shortName: "Titusz", search: "Tit", chapters: 3),
        Book(index: 17, covenant: .new, name: "Pál levele Filemonhoz", shortName: "Filemon", search: "Filem", chapters: 1),
        Book(index: 18, covenant: .new, name: "A zsidókhoz írt levél", shortName: "Zsidók", search: "Zsid", chapters: 13),
        Book(index: 19, covenant: .new, name: "Jakab levele", shortName: "Jakab", search: "Jak", chapters: 5),
        Book(index: 20, covenant: .new, name: "Péter 1. levele", shortName: "1Péter", search: "1Pet", chapters: 5),
        Book(index: 21, covenant: .new, name: "Péter 2. levele", shortName: "2Péter", search: "2Pet", chapters: 3),
        Book(index: 22, covenant: .new, name: "János 1. levele", shortName: "1János", search: "1Jan", chapters: 5),
        Book(index: 23, covenant: .new, name: "János 2. levele", shortName: "2János", search: "2Jan", chapters: 1),
        Book(index: 24, covenant: .new, name: "János 3. levele", shortName: "3János", search: "3Jan", chapters: 1),
        Book(index: 25, covenant: .new, name: "Júdás levele", shortName: "Júdás", search: "Jud", chapters: 1),
        Book(index: 26, covenant: .new, name: "Jelenések könyve", shortName: "Jelenések", search: "Jel", chapters: 22),
    ]
    
    static func index(_ book: Book) -> Int {
        let i = books.firstIndex(where: {$0.name == book.name})!
        return i
    }
}



        
