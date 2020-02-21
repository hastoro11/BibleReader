//
//  TitleView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    @Binding var showSettings: Bool
    @Binding var selectedTab: Int
    var book: Book
    var chapter: Int
    var body: some View {
        HStack {
            InitialView(char: book.abbreviation, color: .black, size: 44)
                .padding(.trailing, 16)
                .multilineTextAlignment(.center)

            InitialView(char: "\(chapter)", color: Color("Green"), size: 44)

            Spacer()
            
            Button(action: {
                self.selectedTab = 0
            }, label: {
                ButtonView(icon: "book", color: Color("Blue"))
            })
                .padding(.horizontal, 16)
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.showSettings.toggle()
                }
            }, label: {
                ButtonView(icon: "gear", color: Color("Red"))
            })
        }
        .padding(.top, 10)
        .padding(.horizontal)
    }
}
