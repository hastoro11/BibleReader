//
//  Label.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 06..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import UIKit

struct Label: UIViewRepresentable {
    typealias UIViewType = UILabel
    var text: String?
    var alignment: NSTextAlignment = .center
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = alignment
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        
    }
}
