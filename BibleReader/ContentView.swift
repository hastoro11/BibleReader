//
//  ContentView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: BibleViewModel
    @State var selectedTab: Int = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            BooksView(viewModel: viewModel, selectedTab: $selectedTab).tabItem {
                Image(systemName: "book")
                Text("Könyvek")
            }.tag(0)
            
            ChapterView(viewModel: viewModel, selectedTab: $selectedTab).tabItem {
                Image(systemName: "doc.plaintext")
                Text("Olvasás")
            }
            .tag(1)
            .environmentObject(BibleViewModel())
            
            FavoritesView(viewModel: viewModel, selectedTab: $selectedTab)
                .tabItem {
                Image(systemName: "star")
                Text("Kedvencek")
            }
            .tag(2)
            
            SettingView(viewModel: viewModel).tabItem {
                Image(systemName: "gauge")
                Text("Beállítások")
            }
            .tag(3)
        }
        .accentColor(.black)
        .onAppear {
            self.selectedTab = self.viewModel.saveLastPosition ? 1 : 0
        }
    }
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
