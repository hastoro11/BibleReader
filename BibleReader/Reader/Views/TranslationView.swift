//
//  TranslationView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 21..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TranslationView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var showTranslation: Bool
    var viewModel: BibleViewModel
    var selectedTab: Int
    @State var dragAmount: CGSize = .zero
    var body: some View {
        
        let dragGesture = DragGesture()
            .onChanged({self.dragAmount = $0.translation})
            .onEnded({_ in
                if self.dragAmount.height < 75 {
                    self.dragAmount = .zero
                }
                else {
                    self.showTranslation = false
                    self.dragAmount = .zero
                }
            })
        
        return ZStack(alignment: .top) {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geo in
                VStack {
                    HStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 2, style: RoundedCornerStyle.circular)
                            .fill(Color.gray)
                            .frame(width: 150, height: 4)
                            .padding()
                        Spacer()
                    }
                    .gesture(dragGesture)
                    
                    ForEach(Translation.allCases, id:\.self) { tr in
                        Group {
                            if !self.viewModel.book.isCatholicBook() || !(tr == .RUF || tr == .KG) || self.selectedTab == 0 {
                                Button(action: {
                                    self.viewModel.translation = tr
                                    withAnimation(.easeInOut) {
                                        self.showTranslation = false
                                    }
                                }, label: {
                                    HStack {
                                        InitialView(char: tr.rawValue, color: tr.color, size: 36)
                                        Text(tr.description)
                                            .font(.secondaryTitle)
                                        Spacer()
                                    }
                                })
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                            }
                        }
                        
                    }
                    Spacer()
                }
                .frame(width: geo.size.width * (self.horizontalSizeClass == .regular ? 0.8 : 1.0))
            }
            
        }
        .offset(x: 0, y: self.dragAmount.height)
        .animation(.spring())
    }
}

//struct TranslationView_Previews: PreviewProvider {
//    static var previews: some View {
//        TranslationView()
//    }
//}
