//
//  ChapterSettingView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ChapterSettingView: View {
    @EnvironmentObject var settings: UserSettings
    @State var dragAmount: CGSize = .zero
    @Binding var showSettings: Bool
    
     var body: some View {
        
        let dragGesture = DragGesture()
        .onChanged({self.dragAmount = $0.translation})
        .onEnded({_ in
            if self.dragAmount.height < 75 {
                self.dragAmount = .zero
            }
            else {
                self.showSettings = false
                self.dragAmount = .zero
            }
        })
        
        return ZStack(alignment: .top) {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 2, style: RoundedCornerStyle.circular)
                        .fill(Color.gray)
                        .frame(width: 150, height: 4)
                        .padding()
                    Spacer()
                }
                .gesture(dragGesture)
                    
                FontTypeSettingsView(fontType: $settings.fontType)
                    .padding()
                
                FontSizeSettingsView(fontSize: $settings.fontsize)
                    .padding()
                      
                ReadingSettingsView(reading: $settings.reading)
                    .padding()
                
                VersIndexSettingsView(showVerses: $settings.showVerses)
                    .padding()
            }
        }
        .offset(x: 0, y: dragAmount.height)
        .animation(.spring())
    }
}

struct FontTypeSettingsView: View {
    @Binding var fontType: FontType
    var body: some View {
        HStack {
            Text("Betűtípus")
                .font(.system(size: 20))
                .frame(width: 120, alignment: .leading)
            
            ForEach(betuk, id:\.name) { betu in
                HStack {
                    Text("Aa")
                        .font(.custom(betu.name, size: betu.size))
                        .frame(width: 50, height: 35)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.fontType == betu.fontType ? 0.2 : 0.0)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.fontType == betu.fontType ? Color.black : Color.gray, lineWidth: self.fontType == betu.fontType ? 1 : 0.5))
                        .padding(.trailing, 24)
                        .onTapGesture {
                            self.fontType = betu.fontType
                    }
                }
            }
        }
    }
}

struct FontSizeSettingsView: View {
    @Binding var fontSize: CGFloat
    var body: some View {
        HStack {
            Text("Betűméret")
                .font(.system(size: 20))
                .frame(width: 120, alignment: .leading)
            
            HStack {
                Button(action: {
                    self.fontSize = max(18, self.fontSize - 2)
                }, label: {
                    Text("-")
                        .font(.title)
                })
                    .frame(width: 50, height: 35)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
                
                
                Text(String(format: "%g", Double(fontSize)))
                    .frame(width: 30)
                    .padding(.horizontal)
                Button(action: {
                    self.fontSize = min(32, self.fontSize + 2)
                }, label: {
                    Text("+")
                        .font(.title)
                })
                    .frame(width: 50, height: 35)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
            }.foregroundColor(.black)
        }
    }
}

struct ReadingSettingsView: View {
    @Binding var reading: Reading
    var body: some View {
        HStack {
            Text("Olvasás")
                .font(.system(size: 20))
                .frame(width: 120, alignment: .leading)
            
            Text("Folyamatos")
                .font(.subheadline)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.reading == .continuous ? 0.2 : 0.0)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.reading == .continuous ? Color.black : Color.gray, lineWidth: self.reading == .continuous ? 1 : 0.5))
                .padding(.trailing, 12)
                .onTapGesture {
                    self.reading = .continuous
            }
            
            Text("Versenként")
                .font(.subheadline)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.reading == .vers ? 0.2 : 0.0)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.reading == .vers ? Color.black : Color.gray, lineWidth: self.reading == .vers ? 1 : 0.5))
                .onTapGesture {
                    self.reading = .vers
            }
        }
    }
}

struct VersIndexSettingsView: View {
    @Binding var showVerses: Bool
    var body: some View {
        HStack {
            Text("Igeversek")
                .font(.system(size: 20))
                .frame(width: 120, alignment: .leading)
            
            Text("Igen")
                .font(.subheadline)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.showVerses ? 0.2 : 0.0)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.showVerses ? Color.black : Color.gray, lineWidth: self.showVerses ? 1 : 0.5))
                .padding(.trailing, 12)
                .onTapGesture {
                    self.showVerses = true
                }
            
            Text("Nem")
                .font(.subheadline)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(!self.showVerses ? 0.2 : 0.0)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(!self.showVerses ? Color.black : Color.gray, lineWidth: !self.showVerses ? 1 : 0.5))
                .padding(.trailing, 12)
                .onTapGesture {
                    self.showVerses = false
                }
        }
    }
}

struct Betu {
    var name: String
    var size: CGFloat
    var fontType: FontType
}

var betuk = [
    Betu(name: "CormorantGaramond-Light", size: 24, fontType: FontType.cormorant),
    Betu(name: "CrimsonPro-Light", size: 24, fontType: FontType.crimson),
    Betu(name: "Maitree-Light", size: 20, fontType: FontType.maitree),
]
