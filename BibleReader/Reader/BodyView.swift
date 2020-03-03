//
//  BodyView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct BodyView: View {
    @EnvironmentObject var settings: UserSettings
    var title: String
    var subtitle: String
    var result: Result?
    var body: some View {
        ScrollView {
            VStack {
                Text(title)
                    .font(.custom("Georgia", size: 32))
                Text(subtitle)
                    .font(.custom("Georgia", size: 24))
                    .padding(.bottom, 32)
                if result != nil {
                    VStack(alignment: .leading) {
                        ForEach(0..<result!.valasz.versek.count, id:\.self) { index in
                            Text("\(index + 1) ")
                                .font(Font.custom(self.settings.fontType.name, size: self.settings.fontsize))
                                .fontWeight(.heavy)
                                + Text(self.result!.valasz.versek[index].szoveg)
                                    .font(Font.custom(self.settings.fontType.name, size: self.settings.fontsize))
                            
                        }
                        .padding(.bottom, 4)
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
