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
    @State var selectedTab = 0
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
            
            Text("Kedvencek").tabItem {
                Image(systemName: "star")
                Text("Kedvencek")
            }
            .tag(2)
            
            Text("Jegyzetek").tabItem {
                Image(systemName: "doc.text")
                Text("Jegyzetek")
            }
            .tag(3)
        }
//        .edgesIgnoringSafeArea(.top)
        .accentColor(.black)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
