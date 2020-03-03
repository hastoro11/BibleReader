//
//  TopRoundedShape.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 14..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TopRoundedShape: Shape {
    var cornerRadius: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: .init(x: rect.minX, y: rect.minY + cornerRadius))
        let center1 = CGPoint.init(x: cornerRadius, y: cornerRadius)
        path.addArc(center: center1, radius: cornerRadius, startAngle: .init(degrees: 180), endAngle: .init(degrees: 270), clockwise: false)
        path.addLine(to: .init(x: rect.maxX -  cornerRadius, y: rect.minY))
        let center2 = CGPoint.init(x: rect.maxX - cornerRadius, y: cornerRadius)
        path.addArc(center: center2, radius: cornerRadius, startAngle: .init(degrees: 270), endAngle: .init(degrees: 360), clockwise: false)
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct TopRoundedBorder: Shape {
    var cornerRadius: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: .init(x: rect.minX, y: rect.minY + cornerRadius))
        let center1 = CGPoint.init(x: cornerRadius, y: cornerRadius)
        path.addArc(center: center1, radius: cornerRadius, startAngle: .init(degrees: 180), endAngle: .init(degrees: 270), clockwise: false)
        path.addLine(to: .init(x: rect.maxX -  cornerRadius, y: rect.minY))
        let center2 = CGPoint.init(x: rect.maxX - cornerRadius, y: cornerRadius)
        path.addArc(center: center2, radius: cornerRadius, startAngle: .init(degrees: 270), endAngle: .init(degrees: 360), clockwise: false)
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}

struct TopShape: PreviewProvider {
    static var previews: some View {
        TopRoundedBorder(cornerRadius: 20).stroke(Color.blue, lineWidth: 5)
    }
}
