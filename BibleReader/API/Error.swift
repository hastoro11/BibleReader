//
//  Error.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 20..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

enum BibleError: Error, CustomStringConvertible {
    case network, parsing, unknown
    
    var description: String {
        switch self {
        case .network:
            return "Kapcsolódási hiba"
        case .parsing:
            return "Konvertálási hiba"
        case .unknown:
            return "Ismeretlen hiba"
        }
    }
}
