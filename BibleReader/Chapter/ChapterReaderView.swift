//
//  ChapterView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ChapterView: View {
    
    @EnvironmentObject var settings: UserSettings
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var viewModel: BibleViewModel
    @State var hideBars: Bool = false
    @State var showSettings = false
    @State var showTranslation = false
    @State var showContextMenu = false
    @Binding var selectedTab: Int
    
    var body: some View {
        
        return GeometryReader { geo in
            VStack {
                if !self.hideBars {
                    TitleView(showSettings: self.$showSettings,showTranslations: self.$showTranslation, selectedTab: self.$selectedTab, viewModel: self.viewModel)
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
                        if self.showTranslation {
                            TranslationView(showTranslation: self.$showTranslation, viewModel: self.viewModel)
                                .frame(width: geo.size.width, height: self.horizontalSizeClass == .compact ? 220 : 220)                                
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
            .background(Color.black.opacity(self.showSettings || self.showTranslation || self.showContextMenu ? 0.2 : 0.0).edgesIgnoringSafeArea(.all))
            .alert(item: self.$viewModel.error) { (error) -> Alert in
                Alert(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("OK")))
            }            
        }
        
    }    
}
