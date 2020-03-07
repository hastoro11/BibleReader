//
//  Font+Extension.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 12..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import UIKit
import SwiftUI

extension Font {
    static var normal: Font {
        return self.custom("Fira Sans Light", size: 20)
    }
    
    static var smallBody: Font {
        return self.custom("Fira Sans Light", size: 16)
    }
    
    static var bigBody: Font {
        return self.custom("Fira Sans Light", size: 22)
    }
    
    static var tallBody: Font {
        return self.custom("Fira Sans Light", size: 24)
    }
    
    static var smallTitle: Font {
        return self.custom("Fira Sans Medium", size: 12)
    }
    
    static var secondaryTitle: Font {
        return self.custom("Fira Sans Medium", size: 16)
    }
    
    static var boldTitle: Font {
        return self.custom("Fira Sans Bold", size: 24)
    }

}
