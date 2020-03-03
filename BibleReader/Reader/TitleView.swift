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
    var body: some View {
        HStack {
            Spacer()
            Text("2Mózes")
                .padding(.horizontal)
                .font(.custom("Georgia", size: 20))
                .offset(x: 28)
            Spacer()
            Button(action: {
                withAnimation(.easeInOut) {
                    self.showSettings.toggle()
                }
            }, label: {
                Image(systemName: "gear")
                    .font(.title)
                    .foregroundColor(.black)
            })
                .padding(.horizontal)
                .padding(.vertical, 8)
        }
    }
}
