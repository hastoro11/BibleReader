//
//  ChapterView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ChapterView: View {
    @EnvironmentObject var vm: ChapterViewModel
    @EnvironmentObject var settings: UserSettings
    @State var hideTitleBar = false
    @State var showSettings = false
    var body: some View {
        VStack {
            if !hideTitleBar {
                TitleView(showSettings: $showSettings)
            }
            ZStack {
                BodyView(title: "Mózes 2. könyve", subtitle: "35. fejezet", result: vm.result)
                    .padding(.top, hideTitleBar ? 10 : 0)
                    .onTapGesture {
                        withAnimation() {
                            self.hideTitleBar.toggle()
                        }
                    }
                
                VStack {
                    if showSettings {
                        SettingsView()
                            .transition(.move(edge: .bottom))
                    }
                }
                
            }
        }
        .background(Color.black.opacity(showSettings ? 0.2 : 0.0).edgesIgnoringSafeArea(.all))
        
    }
}

struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterView()
    }
}
