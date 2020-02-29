//
//  UserSettings.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

class ChapterSettings: ObservableObject {
    @Published var fontType = FontType.medium
    @Published var fontsize: CGFloat = 24
    @Published var reading: Reading = .vers
    @Published var showVerses: Bool = true
}


enum FontType {
    case small, medium, big, tall
    
    var value: Font {
        switch self {
        case .small:
            return Font.smallBody
        case .medium:
            return Font.normal
        case .big:
            return Font.bigBody
        case .tall:
            return Font.tallBody
        }
    }
}

enum Reading {
    case continuous, vers
}
