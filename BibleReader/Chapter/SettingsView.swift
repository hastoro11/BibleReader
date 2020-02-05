//
//  SettingsView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(height: 300)
                VStack {
                    HStack {
                        Text("Font")
                            .font(.system(size: 20))
                            .frame(width: 100, alignment: .leading)
                        
                        HStack {
                            Text("Aa")
                                .font(.custom("Maitree-Light", size: 20))
                                .frame(width: 50, height: 35)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(settings.fontType == .maitree ? Color.black : Color.gray, lineWidth: settings.fontType == .maitree ? 2 : 0.5))
//                                .border(settings.fontType == .maitree ? Color.black : Color.gray, width: settings.fontType == .maitree ? 2 : 0.5)
                                .onTapGesture {
                                    self.settings.fontType = .maitree
                                }
                            Spacer()
                            
                            Text("Aa")
                                .font(.custom("CrimsonPro-Light", size: 24))
                                .frame(width: 50, height: 35)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(settings.fontType == .crimson ? Color.black : Color.gray, lineWidth: settings.fontType == .crimson ? 2 : 0.5))
                                .onTapGesture {
                                    self.settings.fontType = .crimson
                                }
                            Spacer()
                            
                            Text("Aa")
                                .font(.custom("CormorantGaramond-Light", size: 24))
                                .frame(width: 50, height: 35)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(settings.fontType == .cormorant ? Color.black : Color.gray, lineWidth: settings.fontType == .cormorant ? 2 : 0.5))
                                .onTapGesture {
                                    self.settings.fontType = .cormorant
                                }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.top, 24)
                    .padding(.leading, 16)
                    
                    HStack {
                        Text("Size")
                        .font(.system(size: 20))
                        .frame(width: 100, alignment: .leading)
                        HStack {
                            Button(action: {
                                self.settings.fontsize = max(16, self.settings.fontsize - 2)
                            }, label: {
                                Text("-")
                                    .foregroundColor(.black)
                                    .font(.largeTitle)
                            })
                                .frame(width: 50, height: 35)
                                .padding(5)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                            Text(String(format: "%g", settings.fontsize))
                                .padding(.horizontal)
                            Button(action: {
                                self.settings.fontsize = min(28, self.settings.fontsize + 2)
                            }, label: {
                                Text("+")
                                    .foregroundColor(.black)
                                    .font(.title)
                            })
                            .frame(width: 50, height: 35)
                            .padding(5)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        }
                        Spacer()
                    }
                    .padding(.top, 24)
                    .padding(.leading, 16)
                    
                    Spacer()
                }
                .frame(height: 300)
            }
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
