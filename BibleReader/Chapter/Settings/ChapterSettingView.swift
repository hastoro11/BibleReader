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
        
        return GeometryReader { geo in
            ZStack(alignment: .top) {
                Color(UIColor.systemBackground)
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
                    
                    FontSizeSettingsView(fontType: self.$settings.fontType)
                        .padding(10)
                          
                    ReadingSettingsView(reading: self.$settings.reading)
                        .padding(10)
                    
                    VersIndexSettingsView(showVerses: self.$settings.showVerses)
                        .padding(10)
                }
                .padding(.leading)
            }
            .offset(x: 0, y: self.dragAmount.height)
            .animation(.spring())
        }
        
        
    }
}

struct FontSizeSettingsView: View {
    @Binding var fontType: FontType
    var body: some View {
        HStack {
            Text("Betűméret")
                .font(.custom("Fira Sans Medium", size:16))
                .frame(width: 120, alignment: .leading)
            
            HStack {
                
                Text("Aa")
                    .font(.smallBody)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.fontType == .small ? 0.2 : 0.0)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.fontType == .small ? Color.black : Color.gray, lineWidth: self.fontType == .small ? 1 : 0.5))
                    .padding(.trailing, 12)
                    .onTapGesture {
                        self.fontType = .small
                    }
                
                Text("Aa")
                .font(.body)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.fontType == .medium ? 0.2 : 0.0)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.fontType == .medium ? Color.black : Color.gray, lineWidth: self.fontType == .medium ? 1 : 0.5))
                .padding(.trailing, 12)
                .onTapGesture {
                    self.fontType = .medium
                }
                
                Text("Aa")
                .font(.bigBody)
                .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.fontType == .big ? 0.2 : 0.0)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.fontType == .big ? Color.black : Color.gray, lineWidth: self.fontType == .big ? 1 : 0.5))
                .padding(.trailing, 12)
                .onTapGesture {
                    self.fontType = .big
                }
                
                
                Text("Aa")
                .font(.tallBody)
                .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.fontType == .tall ? 0.2 : 0.0)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.fontType == .tall ? Color.black : Color.gray, lineWidth: self.fontType == .tall ? 1 : 0.5))
                .padding(.trailing, 12)
                .onTapGesture {
                    self.fontType = .tall
                }
                
                
                
                
            }.foregroundColor(.black)
        }
    }
}

struct ReadingSettingsView: View {
    @Binding var reading: Reading
    var body: some View {
        HStack {
            Text("Olvasás")
                .font(.custom("Fira Sans Medium", size: 16))
                .frame(width: 120, alignment: .leading)
            
            Text("Folyamatos")
                .font(.custom("Fira Sans Regular", size: 14))
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.reading == .continuous ? 0.2 : 0.0)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.reading == .continuous ? Color.black : Color.gray, lineWidth: self.reading == .continuous ? 1 : 0.5))
                .padding(.trailing, 12)
                .onTapGesture {
                    self.reading = .continuous
            }
            
            Text("Versenként")
                .font(.custom("Fira Sans Regular", size: 14))
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
                .font(.custom("Fira Sans Medium", size: 16))
                .frame(width: 120, alignment: .leading)
            
            Text("Igen")
                .font(.custom("Fira Sans Regular", size: 14))
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.showVerses ? 0.2 : 0.0)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.showVerses ? Color.black : Color.gray, lineWidth: self.showVerses ? 1 : 0.5))
                .padding(.trailing, 12)
                .onTapGesture {
                    self.showVerses = true
                }
            
            Text("Nem")
                .font(.custom("Fira Sans Regular", size: 14))
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
//    var fontType: FontType
}

//var betuk = [
//    Betu(name: "Avenir-Light", size: 22, fontType: FontType.avenir),
//    Betu(name: "CrimsonPro-Light", size: 24, fontType: FontType.crimson),
//    Betu(name: "Maitree-Light", size: 20, fontType: FontType.maitree),
//]
