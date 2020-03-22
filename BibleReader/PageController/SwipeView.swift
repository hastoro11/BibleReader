//
//  SwipeView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 03. 22..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI



struct SwipeView: View {
    var pages: [String]
    @Binding var index: Int
    @State var offset: CGFloat = 0
    @State var isUserSwiping = false
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(self.pages.indices, id:\.self) {index in
                        PageView(name: self.pages[index])
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
            }
            .content
            .offset(x: self.isUserSwiping ? self.offset : -geo.size.width * CGFloat(self.index))
            .frame(width: geo.size.width, height: geo.size.height, alignment: .leading)
            .gesture(DragGesture()
                .onChanged({value in
                    self.isUserSwiping = true
                    self.offset = value.translation.width + -geo.size.width * CGFloat(self.index)
                }).onEnded({value in
                    if value.predictedEndTranslation.width < geo.size.width / 2 && self.index < self.pages.count - 1 {
                        withAnimation {
                            self.index += 1
                        }
                    }
                    if value.predictedEndTranslation.width > geo.size.width / 2 && self.index > 0 {
                        withAnimation {
                            self.index -= 1
                        }
                    }
                    withAnimation {
                        self.isUserSwiping = false
                    }
                })
        )
        }
    }
}

struct PageView: View {
    var name: String
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .clipped()
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView(pages: ["Books", "Chapters", "Translation_1", "Translation_2"], index: .constant(0))
    }
}
