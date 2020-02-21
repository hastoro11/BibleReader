//
//  CommonViews.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 14..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct InitialView: View {
    var char: String
    var color: Color
    var size: CGFloat
    var body: some View {
        Text(String(char.prefix(4)))
            .foregroundColor(.white)
            .font(.secondaryTitle)
            .frame(width: size, height: size)
            .background(Circle().fill(color))
            .lineLimit(1)
            .allowsTightening(true)
    }
}

struct ButtonView: View {
     var icon: String
       var color: Color
       var body: some View {
        Image(systemName: icon)
            .font(.custom("Fira Sans Medium", size: 24))
               .foregroundColor(.white)
               .font(.secondaryTitle)
               .frame(width: 44, height: 44)
               .background(Circle().fill(color))
       }
}
