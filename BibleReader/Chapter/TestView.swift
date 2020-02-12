//
//  TestView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 12..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(Font.custom("Fira Sans Light", size: 24))
            Text("Hello world")
            
        }
            
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
