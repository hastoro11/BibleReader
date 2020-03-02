//
//  Response.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 20..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - ChapterResponse
struct ChapterResponse: Codable {
    let keres: Keres
    let valasz: Valasz

    enum CodingKeys: String, CodingKey {
        case keres = "keres"
        case valasz = "valasz"
    }
}

// MARK: - Keres
struct Keres: Codable {
    let feladat: String
    let hivatkozas: String
    let forma: String

    enum CodingKeys: String, CodingKey {
        case feladat = "feladat"
        case hivatkozas = "hivatkozas"
        case forma = "forma"
    }
}

// MARK: - Valasz
struct Valasz: Codable {
    let versek: [Versek]
    let forditas: Forditas

    enum CodingKeys: String, CodingKey {
        case versek = "versek"
        case forditas = "forditas"
    }
}

// MARK: - Forditas
struct Forditas: Codable {
    let nev: String
    let rov: String

    enum CodingKeys: String, CodingKey {
        case nev = "nev"
        case rov = "rov"
    }
}

// MARK: - Versek
struct Versek: Codable {
    let szoveg: String?
//    let jegyzetek: [String]?
    let hely: Hely
    var forditas: String?

    enum CodingKeys: String, CodingKey {
        case szoveg = "szoveg"
//        case jegyzetek = "jegyzetek"
        case hely = "hely"
        case forditas = "forditas"
    }
}

extension Versek: Identifiable {
    var id: Int {
        self.hely.gepi
    }
}

extension Versek: Equatable {
    static func == (lhs: Versek, rhs: Versek) -> Bool {
        return lhs.hely.gepi == rhs.hely.gepi
    }
}

// MARK: - Hely
struct Hely: Codable {
    let gepi: Int
    let szep: String

    enum CodingKeys: String, CodingKey {
        case gepi = "gepi"
        case szep = "szep"
    }
}

// MARK: - Favorites
struct Favorite: Codable, Identifiable {
    var id: Int {
        return vers.hely.gepi
    }
    var vers: Versek
    var book: String
    var chapter: Int    
    var forditas: String
}

