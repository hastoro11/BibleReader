//
//  UserSettings.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

class UserSettings: ObservableObject {
    @Published var fontType = FontType.cormorant
    @Published var fontsize: CGFloat = 20
}


enum FontType {
    case cormorant, crimson, maitree
    
    var name: String {
        switch self {
        case .cormorant:
            return "CormorantGaramond-Light"
        case .crimson:
            return "CrimsonPro-Light"
        case .maitree:
            return "Maitree-Light"
        }
    }
}
