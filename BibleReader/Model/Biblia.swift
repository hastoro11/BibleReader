//
//  Biblia.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 07..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation
import SwiftUI

enum Translation: String, CaseIterable, CustomStringConvertible{

    case RUF, KG, KNB, SZIT
    
    var description: String {
        switch self {
        case .RUF:
            return "Magyar Bibliatársulat újfordítású Bibliája (2014)"
        case .KG:
            return "Károli Gáspár revideált fordítása"
        case .KNB:
            return "Káldi-Neovulgáta"
        case .SZIT:
            return "Szent István Társulati Biblia"
        }
    }
    
    var color: Color {
        switch self {
        case .RUF:
            return Color("Red")
        case .KG:
            return Color("Blue")
        case .KNB:
            return Color.black
        case .SZIT:
            return Color("Gray")
        }
    }
    
    var books: [Book] {
        switch self {
        case .RUF, .KG:
            return Biblia.books
        case .KNB, .SZIT:
            return Biblia.catholicBooks
        }
    }
    
    func hasBook(_ book: String) -> Bool {
        return self.books.contains(where: {$0.abbreviation == book})
    }
    
}

enum Covenant: String, Codable {
    case old, new
}

struct Book: Codable, Equatable {
    var covenant: Covenant
    var name: String
    var shortName: String
    var abbreviation: String
    var chapters: Int
    
    func isCatholicBook() -> Bool {
        return self == Biblia.catholicBooks[16] || self == Biblia.catholicBooks[17] || self == Biblia.catholicBooks[24] || self == Biblia.catholicBooks[25] || self == Biblia.catholicBooks[29] || self == Biblia.catholicBooks[44] || self == Biblia.catholicBooks[45]
    }
}

struct Biblia {
    static var books: [Book] = [
        Book(covenant: .old, name: "Mózes 1. könyve", shortName: "1Mózes", abbreviation: "1Móz",  chapters: 50),
        Book(covenant: .old, name: "Mózes 2. könyve", shortName: "2Mózes", abbreviation: "2Móz", chapters: 40),
        Book(covenant: .old, name: "Mózes 3. könyve", shortName: "3Mózes", abbreviation: "3Móz", chapters: 27),
        Book(covenant: .old, name: "Mózes 4. könyve", shortName: "4Mózes", abbreviation: "4Móz", chapters: 36),
        Book(covenant: .old, name: "Mózes 5. könyve", shortName: "5Mózes", abbreviation: "5Móz", chapters: 34),
        Book(covenant: .old, name: "Józsué könyve", shortName: "Józsue", abbreviation: "Józs", chapters: 24),
        Book(covenant: .old, name: "Bírák könyve", shortName: "Bírák", abbreviation: "Bírák", chapters: 21),
        Book(covenant: .old, name: "Ruth könyve", shortName: "Ruth", abbreviation: "Ruth", chapters: 4),
        Book(covenant: .old, name: "Sámuel 1. könyve", shortName: "1Sámuel", abbreviation: "1Sám", chapters: 31),
        Book(covenant: .old, name: "Sámuel 2. könyve", shortName: "2Sámuel", abbreviation: "2Sám", chapters: 24),
        Book(covenant: .old, name: "Királyok 1. könyve", shortName: "1Kir", abbreviation: "1Kir", chapters: 22),
        Book(covenant: .old, name: "Királyok 2. könyve", shortName: "2Kir", abbreviation: "2Kir", chapters: 25),
        Book(covenant: .old, name: "Krónikák 1. könyve", shortName: "1Krón", abbreviation: "1Krón", chapters: 29),
        Book(covenant: .old, name: "Krónikák 2. könyve", shortName: "2Krón", abbreviation: "2Krón", chapters: 36),
        Book(covenant: .old, name: "Ezsdrás könyve", shortName: "Ezsdrás", abbreviation: "Ezsdr", chapters: 10),
        Book(covenant: .old, name: "Nehémiás könyve", shortName: "Nehémiás", abbreviation: "Neh", chapters: 13),
        Book(covenant: .old, name: "Eszter könyve", shortName: "Eszter", abbreviation: "Eszt", chapters: 10),
        Book(covenant: .old, name: "Jób könyve", shortName: "Jób", abbreviation: "Jób", chapters: 42),
        Book(covenant: .old, name: "Zsoltárok könyve", shortName: "Zsoltárok", abbreviation: "Zsolt", chapters: 150),
        Book(covenant: .old, name: "Példabeszédek könyve", shortName: "Példabeszédek", abbreviation: "Péld", chapters: 31),
        Book(covenant: .old, name: "Prédikátor könyve", shortName: "Prédikátor", abbreviation: "Préd", chapters: 12),
        Book(covenant: .old, name: "Énekek éneke", shortName: "Énekek", abbreviation: "Énekek", chapters: 8),
        Book(covenant: .old, name: "Ézsaiás könyve", shortName: "Ézsaiás", abbreviation: "Ézs", chapters: 66),
        Book(covenant: .old, name: "Jeremiás könyve", shortName: "Jeremiás", abbreviation: "Jer", chapters: 52),
        Book(covenant: .old, name: "Jeremiás siralmai", shortName: "JerSir", abbreviation: "JSir", chapters: 5),
        Book(covenant: .old, name: "Ezékiel könyve", shortName: "Ezékiel", abbreviation: "Ez", chapters: 48),
        Book(covenant: .old, name: "Dániel könyve", shortName: "Dániel", abbreviation: "Dán", chapters: 12),
        Book(covenant: .old, name: "Hóseás könyve", shortName: "Hóseás", abbreviation: "Hós", chapters: 14),
        Book(covenant: .old, name: "Jóel könyve", shortName: "Jóel", abbreviation: "Jóel", chapters: 4),
        Book(covenant: .old, name: "Ámósz könyve", shortName: "Ámosz", abbreviation: "Ám", chapters: 9),
        Book(covenant: .old, name: "Abdiás könyve", shortName: "Abdiás", abbreviation: "Abd", chapters: 1),
        Book(covenant: .old, name: "Jónás könyve", shortName: "Jónás", abbreviation: "Jón", chapters: 4),
        Book(covenant: .old, name: "Mikeás könyve", shortName: "Mikeás", abbreviation: "Mik", chapters: 7),
        Book(covenant: .old, name: "Náhum könyve", shortName: "Náhum", abbreviation: "Náh", chapters: 3),
        Book(covenant: .old, name: "Habakuk könyve", shortName: "Habakuk", abbreviation: "Hab", chapters: 3),
        Book(covenant: .old, name: "Zofóniás könyve", shortName: "Zofóniás", abbreviation: "Zof", chapters: 3),
        Book(covenant: .old, name: "Haggeus könyve", shortName: "Haggeus", abbreviation: "Hag", chapters: 2),
        Book(covenant: .old, name: "Zakariás könyve", shortName: "Zakariás", abbreviation: "Zak", chapters: 14),
        Book(covenant: .old, name: "Malakiás könyve", shortName: "Malakiás", abbreviation: "Mal", chapters: 3),
        Book(covenant: .new, name: "Máté evangéliuma", shortName: "Máté", abbreviation: "Máté", chapters: 28),
        Book(covenant: .new, name: "Márk evangéliuma", shortName: "Márk", abbreviation: "Márk", chapters: 16),
        Book(covenant: .new, name: "Lukács evangéliuma", shortName: "Lukács", abbreviation: "Luk", chapters: 24),
        Book(covenant: .new, name: "János evangéliuma", shortName: "János", abbreviation: "Ján", chapters: 21),
        Book(covenant: .new, name: "Az apostolok cselekedetei", shortName: "ApCsel", abbreviation: "ApCsel", chapters: 28),
        Book(covenant: .new, name: "Pál levele a rómaiakhoz", shortName: "Róma", abbreviation: "Róm", chapters: 16),
        Book(covenant: .new, name: "Pál 1. levele a korinthusiakhoz", shortName: "1Kor", abbreviation: "1Kor", chapters: 16),
        Book(covenant: .new, name: "Pál 2. levele a korinthusiakhoz", shortName: "2Kor", abbreviation: "2Kor", chapters: 13),
        Book(covenant: .new, name: "Pál levele a galátákhoz", shortName: "Galáta", abbreviation: "Gal", chapters: 6),
        Book(covenant: .new, name: "Pál levele a efezusiakhoz", shortName: "Efezus", abbreviation: "Ef", chapters: 6),
        Book(covenant: .new, name: "Pál levele a filippiekhez", shortName: "Filippi", abbreviation: "Fil", chapters: 4),
        Book(covenant: .new, name: "Pál levele a kolosséiakhoz", shortName: "Kolossé", abbreviation: "Kol", chapters: 4),
        Book(covenant: .new, name: "Pál 1. levele a thesszalonikaiakhoz", shortName: "1Thessz", abbreviation: "1Thessz", chapters: 5),
        Book(covenant: .new, name: "Pál 2. levele a thesszalonikaiakhoz", shortName: "2Thessz", abbreviation: "2Thessz", chapters: 3),
        Book(covenant: .new, name: "Pál 1. levele Timóteushoz", shortName: "1Tim", abbreviation: "1Tim", chapters: 6),
        Book(covenant: .new, name: "Pál 2. levele Timóteushoz", shortName: "2Tim", abbreviation: "2Tim", chapters: 4),
        Book(covenant: .new, name: "Pál levele Tituszhoz", shortName: "Titusz", abbreviation: "Tit", chapters: 3),
        Book(covenant: .new, name: "Pál levele Filemonhoz", shortName: "Filemon", abbreviation: "Filem", chapters: 1),
        Book(covenant: .new, name: "A zsidókhoz írt levél", shortName: "Zsidók", abbreviation: "Zsid", chapters: 13),
        Book(covenant: .new, name: "Jakab levele", shortName: "Jakab", abbreviation: "Jak", chapters: 5),
        Book(covenant: .new, name: "Péter 1. levele", shortName: "1Péter", abbreviation: "1Pt", chapters: 5),
        Book(covenant: .new, name: "Péter 2. levele", shortName: "2Péter", abbreviation: "2Pt", chapters: 3),
        Book(covenant: .new, name: "János 1. levele", shortName: "1János", abbreviation: "1Jn", chapters: 5),
        Book(covenant: .new, name: "János 2. levele", shortName: "2János", abbreviation: "2Jn", chapters: 1),
        Book(covenant: .new, name: "János 3. levele", shortName: "3János", abbreviation: "3Jn", chapters: 1),
        Book(covenant: .new, name: "Júdás levele", shortName: "Júdás", abbreviation: "Júd", chapters: 1),
        Book(covenant: .new, name: "Jelenések könyve", shortName: "Jelenések", abbreviation: "Jel", chapters: 22),
    ]
    
    static var catholicBooks: [Book] = [
        Book(covenant: .old, name: "Teremtés könyve", shortName: "Teremtés", abbreviation: "Ter", chapters: 50),
        Book(covenant: .old, name: "Kivonulás könyve", shortName: "Kivonulás", abbreviation: "Kiv", chapters: 40),
        Book(covenant: .old, name: "Leviták könyve", shortName: "Leviták", abbreviation: "Lev", chapters: 27),
        Book(covenant: .old, name: "Számok könyve", shortName: "Számok", abbreviation: "Szám", chapters: 36),
        Book(covenant: .old, name: "Második Törvénykönyv", shortName: "Törvénykönyv", abbreviation: "MTörv", chapters: 34),
        Book(covenant: .old, name: "Józsué könyve", shortName: "Józsué", abbreviation: "Józs", chapters: 24),
        Book(covenant: .old, name: "Bírák könyve", shortName: "Bírák", abbreviation: "Bír", chapters: 21),
        Book(covenant: .old, name: "Rut könyve", shortName: "Rut", abbreviation: "Rut", chapters: 4),
        Book(covenant: .old, name: "Sámuel I. könyve", shortName: "1Sámuel", abbreviation: "1Sám", chapters: 31),
        Book(covenant: .old, name: "Sámuel II. könyve", shortName: "2Sámuel", abbreviation: "2Sám", chapters: 24),
        Book(covenant: .old, name: "Királyok I. könyve", shortName: "1Kir", abbreviation: "1Kir", chapters: 22),
        Book(covenant: .old, name: "Királyok II. könyve", shortName: "2Kir", abbreviation: "2Kir", chapters: 25),
        Book(covenant: .old, name: "Krónikák I. könyve", shortName: "1Krón", abbreviation: "1Krón", chapters: 29),
        Book(covenant: .old, name: "Krónikák II. könyve", shortName: "2Krón", abbreviation: "2Krón", chapters: 36),
        Book(covenant: .old, name: "Ezdrás könyve", shortName: "Ezdrás", abbreviation: "Ezd", chapters: 10),
        Book(covenant: .old, name: "Nehemiás könyve", shortName: "Nehemiás", abbreviation: "Neh", chapters: 13),
        Book(covenant: .old, name: "Tóbiás könyve", shortName: "Tóbiás", abbreviation: "Tób", chapters: 14),
        Book(covenant: .old, name: "Judit könyve", shortName: "Judit", abbreviation: "Judit", chapters: 16),
        Book(covenant: .old, name: "Eszter könyve", shortName: "Eszter", abbreviation: "Esz", chapters: 10),
        Book(covenant: .old, name: "Jób könyve", shortName: "Jób", abbreviation: "Jób", chapters: 42),
        Book(covenant: .old, name: "Zsoltárok könyve", shortName: "Zsoltárok", abbreviation: "Zsolt", chapters: 150),
        Book(covenant: .old, name: "Példabeszédek könyve", shortName: "Példabeszédek", abbreviation: "Péld", chapters: 31),
        Book(covenant: .old, name: "Prédikátor könyve", shortName: "Prédikátor", abbreviation: "Préd", chapters: 12),
        Book(covenant: .old, name: "Énekek éneke", shortName: "Énekek", abbreviation: "Én", chapters: 8),
        Book(covenant: .old, name: "Bölcsesség könyve", shortName: "Bölcsesség", abbreviation: "Bölcs", chapters: 19),
        Book(covenant: .old, name: "Sirák fia könyve", shortName: "Sirák", abbreviation: "Sir", chapters: 51),
        Book(covenant: .old, name: "Izajás könyve", shortName: "Izajás", abbreviation: "Iz", chapters: 66),
        Book(covenant: .old, name: "Jeremiás könyve", shortName: "Jeremiás", abbreviation: "Jer", chapters: 52),
        Book(covenant: .old, name: "Siralmak könyve", shortName: "Siralmak", abbreviation: "Siral", chapters: 5),
        Book(covenant: .old, name: "Báruk könyve", shortName: "Báruk", abbreviation: "Bár", chapters: 6),
        Book(covenant: .old, name: "Ezekiel könyve", shortName: "Ezekiel", abbreviation: "Ez", chapters: 48),
        Book(covenant: .old, name: "Dániel könyve", shortName: "Dániel", abbreviation: "Dán", chapters: 14),
        Book(covenant: .old, name: "Ozeás könyve", shortName: "Ozeás", abbreviation: "Oz", chapters: 14),
        Book(covenant: .old, name: "Joel könyve", shortName: "Joel", abbreviation: "Jo", chapters: 4),
        Book(covenant: .old, name: "Ámosz könyve", shortName: "Ámosz", abbreviation: "Ám", chapters: 9),
        Book(covenant: .old, name: "Abdiás könyve", shortName: "Abdiás", abbreviation: "Abd", chapters: 1),
        Book(covenant: .old, name: "Jónás könyve", shortName: "Jónás", abbreviation: "Jón", chapters: 4),
        Book(covenant: .old, name: "Mikeás könyve", shortName: "Mikeás", abbreviation: "Mik", chapters: 7),
        Book(covenant: .old, name: "Náhum könyve", shortName: "Náhum", abbreviation: "Náh", chapters: 3),
        Book(covenant: .old, name: "Habakuk könyve", shortName: "Habakuk", abbreviation: "Hab", chapters: 3),
        Book(covenant: .old, name: "Szofoniás könyve", shortName: "Szofoniás", abbreviation: "Szof", chapters: 3),
        Book(covenant: .old, name: "Aggeus könyve", shortName: "Aggeus", abbreviation: "Ag", chapters: 2),
        Book(covenant: .old, name: "Zakariás könyve", shortName: "Zakariás", abbreviation: "Zak", chapters: 14),
        Book(covenant: .old, name: "Malakiás könyve", shortName: "Malakiás", abbreviation: "Mal", chapters: 3),
        Book(covenant: .old, name: "Makkabeusok I. könyve", shortName: "1Makk", abbreviation: "1Mak", chapters: 16),
        Book(covenant: .old, name: "Makkabeusok II. könyve", shortName: "2Makk", abbreviation: "2Mak", chapters: 15),
        
        Book(covenant: .new, name: "Máté evangéliuma", shortName: "Máté", abbreviation: "Mt", chapters: 28),
        Book(covenant: .new, name: "Márk evangéliuma", shortName: "Márk", abbreviation: "Mk", chapters: 16),
        Book(covenant: .new, name: "Lukács evangéliuma", shortName: "Lukács", abbreviation: "Lk", chapters: 24),
        Book(covenant: .new, name: "János evangéliuma", shortName: "János", abbreviation: "Jn", chapters: 21),
        Book(covenant: .new, name: "Apostolok Cselekedetei", shortName: "ApCsel", abbreviation: "ApCsel", chapters: 28),
        Book(covenant: .new, name: "Rómaiaknak írt levél", shortName: "Róma", abbreviation: "Róm", chapters: 16),
        Book(covenant: .new, name: "Korintusiaknak írt I. levél", shortName: "1Kor", abbreviation: "1Kor", chapters: 16),
        Book(covenant: .new, name: "Korintusiaknak írt II. levél", shortName: "2Kor", abbreviation: "2Kor", chapters: 13),
        Book(covenant: .new, name: "Galatáknak írt levél", shortName: "Galáta", abbreviation: "Gal", chapters: 6),
        Book(covenant: .new, name: "Efezusiaknak írt levél", shortName: "Efezus", abbreviation: "Ef", chapters: 6),
        Book(covenant: .new, name: "Filippieknek írt levél", shortName: "Filippi", abbreviation: "Fil", chapters: 4),
        Book(covenant: .new, name: "Kolosszeieknek írt levél", shortName: "Kolossé", abbreviation: "Kol", chapters: 4),
        Book(covenant: .new, name: "Tesszalonikaiaknak írt I. levél", shortName: "1Tesz", abbreviation: "1Thessz", chapters: 5),
        Book(covenant: .new, name: "Tesszalonikaiaknak írt II. levél", shortName: "2Tesz", abbreviation: "2Thessz", chapters: 3),
        Book(covenant: .new, name: "Timóteusnak írt I. levél", shortName: "1Tim", abbreviation: "1Tim", chapters: 6),
        Book(covenant: .new, name: "Timóteusnak írt II. levél", shortName: "2Tim", abbreviation: "2Tim", chapters: 4),
        Book(covenant: .new, name: "Titusznak írt levél", shortName: "Titusz", abbreviation: "Tit", chapters: 3),
        Book(covenant: .new, name: "Filemonnak írt levél", shortName: "Filemon", abbreviation: "Filem", chapters: 1),
        Book(covenant: .new, name: "Zsidóknak írt levél", shortName: "Zsidók", abbreviation: "Zsid", chapters: 13),
        Book(covenant: .new, name: "Jakab levele", shortName: "Jakab", abbreviation: "Jak", chapters: 5),
        Book(covenant: .new, name: "Péter I. levele", shortName: "1Péter", abbreviation: "1Pt", chapters: 5),
        Book(covenant: .new, name: "Péter II. levele", shortName: "2Péter", abbreviation: "2Pt", chapters: 3),
        Book(covenant: .new, name: "János I. levele", shortName: "1János", abbreviation: "1Jn", chapters: 5),
        Book(covenant: .new, name: "János II. levele", shortName: "2János", abbreviation: "2Jn", chapters: 1),
        Book(covenant: .new, name: "János III. levele", shortName: "3János", abbreviation: "3Jn", chapters: 1),
        Book(covenant: .new, name: "Júdás levele", shortName: "Júdás", abbreviation: "Júd", chapters: 1),
        Book(covenant: .new, name: "Jelenések könyve", shortName: "Jelenések", abbreviation: "Jel", chapters: 22),
    ]
    
    static var catholic = ["Ter", "Kiv", "Lev", "Szám", "MTörv", "Józs", "Bír", "Rut", "1Sám", "2Sám", "1Kir", "2Kir", "1Krón", "2Krón", "Ezd", "Neh", "Tób", "Judit", "Esz", "Jób", "Zsolt", "Péld", "Préd", "Én", "Bölcs", "Sirák", "Iz", "Jer", "Siral", "Bár", "Ez", "Dán", "Oz", "Jo", "Ám", "Abd", "Jón", "Mik", "Náh", "Hab", "Szof", "Ag", "Zak", "Mal", "1Mak", "2Mak", "Mt", "Mk", "Lk", "Jn", "ApCsel", "Róm", "1Kor", "2Kor", "Gal", "Ef", "Fil", "Kol", "1Tesz", "2Tesz", "1Tim", "2Tim", "Tit", "Filem", "Zsid", "Jak", "1Pt", "2Pt", "1Jn", "2Jn", "3Jn", "Júd", "Jel"]
    static var protestant = ["1Móz", "2Móz", "3Móz", "4Móz", "5Móz", "Józs", "Bírák", "Ruth", "1Sám", "2Sám", "1Kir", "2Kir", "1Krón", "2Krón", "Ezsdr", "Neh", "", "", "Eszt", "Jób", "Zsolt", "Péld", "Préd", "Énekek", "", "", "Ézs", "Jer", "JSir", "", "Ez", "Dán", "Hós", "Jóel", "Ám", "Abd", "Jón", "Mik", "Náh", "Hab", "Zof", "Hag", "Zak", "Mal", "", "", "Máté", "Márk", "Luk", "Ján", "ApCsel", "Róm", "1Kor", "2Kor", "Gal", "Ef", "Fil", "Kol", "1Thessz", "2Thessz", "1Tim", "2Tim", "Tit", "Filem", "Zsid", "Jak", "1Pt", "2Pt", "1Jn", "2Jn", "3Jn", "Júd", "Jel"]
}

