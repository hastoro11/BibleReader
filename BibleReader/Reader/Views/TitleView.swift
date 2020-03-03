//
//  TitleView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var showSettings: Bool
    @Binding var showTranslations: Bool
    @Binding var selectedTab: Int
    @State var showNumbersView = false
    var viewModel: BibleViewModel
    var book: Book {
        return viewModel.book
    }
    var chapter: Int {
        return viewModel.chapter
    }
    var translation: Translation {
        return viewModel.translation
    }
    var body: some View {
            HStack {
                Button(action: {
                    self.selectedTab = 0
                }, label: {
                    InitialView(char: self.book.abbreviation, color: .black, size: 44)
                    .padding(.trailing, 16)
                    .multilineTextAlignment(.center)
                })
                
                Button(action: {
                    self.showNumbersView = true
                }, label: {
                    InitialView(char: "\(self.chapter)", color: Color("Green"), size: 44)
                })
               
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn) {
                        self.showTranslations.toggle()
                        if self.showSettings {
                            self.showSettings = false
                        }
                        
                    }
                }, label: {
                    InitialView(char: "\(self.translation.rawValue)", color: self.translation.color, size: 44)
                })
                    .padding(.horizontal, 16)
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.showSettings.toggle()
                        if self.showTranslations {
                            self.showTranslations = false
                        }
                    }
                }, label: {
                    ButtonView(icon: "gear", color: Color.gray)
                })
            }            
            .padding(.top, 10)
            .padding(.horizontal)            
            .sheet(isPresented: self.$showNumbersView, content: {
                ChapterNumberView(selectedTab: self.$selectedTab, viewModel: self.viewModel)
            })
        
    }
}
