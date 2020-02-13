//
//  ContentView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {        
        TabView {
            BooksView().tabItem {
                Image(systemName: "book")
                Text("Könyvek")
            }
            
            ChapterView().tabItem {
                Image(systemName: "doc.plaintext")
                Text("Olvasás")
            }
            .environmentObject(ChapterViewModel())
            
            Text("Kedvencek").tabItem {
                Image(systemName: "star")
                Text("Kedvencek")
            }
            
            Text("Jegyzetek").tabItem {
                Image(systemName: "doc.text")
                Text("Jegyzetek")
            }
        }
//        .edgesIgnoringSafeArea(.top)
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
