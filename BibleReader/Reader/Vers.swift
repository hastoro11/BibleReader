//
//  Vers.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

struct Vers: Codable {
    var szoveg: String
    var jegyzetek: [String]
    var hely: Hely
}

struct Hely: Codable {
    var gepi: Int
    var szep: String
}
