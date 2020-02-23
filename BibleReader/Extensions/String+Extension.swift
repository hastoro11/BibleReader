//
//  String+Extension.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 14..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

extension String {
    var removedHTMLTags: String {
        let pattern = #"<.*>"#
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
    }
}
