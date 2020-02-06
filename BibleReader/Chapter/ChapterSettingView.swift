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
        ZStack(alignment: .top) {
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
                .gesture(
                    DragGesture()
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
                )
                    
                HStack {
                    Text("Betűtípus")
                        .font(.system(size: 22))
                        .frame(width: 150, alignment: .leading)
                    
                    ForEach(betuk, id:\.name) { betu in
                        HStack {
                            Text("Aa")
                                .font(Font.custom(betu.name, size: betu.size))
                                .frame(width: 50, height: 35)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.settings.fontType == betu.fontType ? 0.2 : 0.0)))
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.settings.fontType == betu.fontType ? Color.black : Color.gray, lineWidth: self.settings.fontType == betu.fontType ? 2 : 0.5))
                                .padding(.trailing, 24)
                                .onTapGesture {
                                    self.settings.fontType = betu.fontType
                                }
                        }
                    }
                }
                .padding()                
                
                HStack {
                    Text("Betűméret")
                        .font(.system(size: 22))
                        .frame(width: 150, alignment: .leading)
                    
                    HStack {
                        Button(action: {
                            self.settings.fontsize = max(18, self.settings.fontsize - 2)
                        }, label: {
                            Text("-")
                                .font(.title)
                        })
                            .frame(width: 50, height: 35)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
                        
                        
                        Text(String(format: "%g", Double(settings.fontsize)))
                            .frame(width: 30)
                            .padding(.horizontal)
                        Button(action: {
                            self.settings.fontsize = min(32, self.settings.fontsize + 2)
                        }, label: {
                            Text("+")
                                .font(.title)
                        })
                            .frame(width: 50, height: 35)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
                    }.foregroundColor(.black)
                }
                .padding()
                      
                HStack {
                    Text("Olvasás")
                        .font(.system(size: 22))
                        .frame(width: 150, alignment: .leading)
                    
                    Text("Folyamatos")
                        .font(.subheadline)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.settings.reading == .continuous ? 0.2 : 0.0)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.settings.reading == .continuous ? Color.black : Color.gray, lineWidth: self.settings.reading == .continuous ? 2 : 0.5))
                        .padding(.trailing, 12)
                        .onTapGesture {
                            self.settings.reading = .continuous
                        }
                    
                    Text("Versenként")
                        .font(.subheadline)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.settings.reading == .vers ? 0.2 : 0.0)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.settings.reading == .vers ? Color.black : Color.gray, lineWidth: self.settings.reading == .vers ? 2 : 0.5))
                        .onTapGesture {
                            self.settings.reading = .vers
                        }
                }
                .padding()
                
                HStack {
                    Text("Igeversek")
                        .font(.system(size: 22))
                        .frame(width: 150, alignment: .leading)
                    
                    Text("Igen")
                        .font(.subheadline)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(self.settings.showVerses ? 0.2 : 0.0)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(self.settings.showVerses ? Color.black : Color.gray, lineWidth: self.settings.showVerses ? 2 : 0.5))
                        .padding(.trailing, 12)
                        .onTapGesture {
                            self.settings.showVerses = true
                        }
                    
                    Text("Nem")
                        .font(.subheadline)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.black.opacity(!self.settings.showVerses ? 0.2 : 0.0)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(!self.settings.showVerses ? Color.black : Color.gray, lineWidth: !self.settings.showVerses ? 2 : 0.5))
                        .padding(.trailing, 12)
                        .onTapGesture {
                            self.settings.showVerses = false
                        }
                }
                .padding()
            }
        }
        .offset(x: 0, y: dragAmount.height)
        .animation(.spring())
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
