//
//  TranslationView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 21..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TranslationView: View {
    @Binding var showTranslation: Bool
    var viewModel: BibleViewModel
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
                .padding()
                }
                
                
                
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
