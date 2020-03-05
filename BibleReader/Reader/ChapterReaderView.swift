//
//  ChapterView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ChapterView: View {
    @EnvironmentObject var settings: ChapterSettingsModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @ObservedObject var viewModel: BibleViewModel
    
    @State var hideBars: Bool = false
    @State var showSettings = false
    @State var showTranslations = false
    @State var showContextMenu = false
    @State var showNumbersView = false
    @State var dragAmount: CGSize = .zero
    
    
    @Binding var selectedTab: Int
    
    // MARK: - Body
    var body: some View {        
        return GeometryReader { geo in
            VStack {
                if !self.hideBars {
                    self.titleView
                        .sheet(isPresented: self.$showNumbersView, content: {
                            ChapterNumberView(selectedTab: self.$selectedTab, viewModel: self.viewModel)
                        })
                        .frame(width: self.calculateSize(width: geo.size.width))
                }
                
                ZStack {
                    BodyView(viewModel: self.viewModel, hideBars: self.$hideBars, showContextMenu: self.$showContextMenu)
                        .padding(.top, self.hideBars ? 10 : 0)                        
                    
                    VStack {
                        Spacer()
                        if self.showSettings {
                            ChapterSettingView(showSettings: self.$showSettings)
                                .frame(width: geo.size.width, height: self.horizontalSizeClass == .compact ? 220 : 220)
                                .transition(.move(edge: .bottom))
                        }
                    }
                    
                    VStack {
                        
                        Spacer()
                        if self.showTranslations {
                            TranslationView(showTranslation: self.$showTranslations, viewModel: self.viewModel, selectedTab: self.selectedTab)
                                .frame(width: geo.size.width, height: 220)
                                .transition(.move(edge: .bottom))
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black.opacity(0.5))
                            .frame(width: 100, height: 100)
                        LoaderView(isLoading: self.viewModel.isLoading)
                    }
                    .opacity(self.viewModel.isLoading ? 1.0 : 0.0)
                    .animation(.easeInOut)
                    
                }
            }            
            .background(Color.black.opacity(self.showSettings || self.showTranslations || self.showContextMenu ? 0.2 : 0.0).edgesIgnoringSafeArea(.all))
            .alert(item: self.$viewModel.error) { (error) -> Alert in
                Alert(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("OK")))
                
            }            
        }
        
    }
}

// MARK: - Subviews

extension ChapterView {
    var titleView: some View {
        return HStack {
            Button(action: {
                self.selectedTab = 0
            }, label: {
                InitialView(char: viewModel.book.abbreviation, color: .black, size: 44)
                .padding(.trailing, 16)
                .multilineTextAlignment(.center)
            })
            
            Button(action: {
                self.showNumbersView = true
            }, label: {
                InitialView(char: "\(viewModel.chapter)", color: Color("Green"), size: 44)
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
                InitialView(char: "\(viewModel.translation.rawValue)", color: viewModel.translation.color, size: 44)
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
        
    }
}

extension ChapterView {
    var bodyView: some View {
        Text("Body")
    }
}

// MARK: - Utils

extension ChapterView {
    func calculateSize(width: CGFloat) -> CGFloat {
        if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return width * 0.8
        }
        return width
    }
}

// MARK: - Gesture

extension ChapterView {
    
}

struct ChapterReaderView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
