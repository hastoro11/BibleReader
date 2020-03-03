//
//  UserSettingsView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 28..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel: BibleViewModel
    @State var saveCurrent = false
    var colors = ["Yellow", "Red", "Blue", "Green", "Gray"]
    
    func sectionHeader(title: String, subTitle: String) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(.boldTitle)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                Text(subTitle)
                    .font(.smallBody)
                    .padding(.trailing)
            }.background(Color.white)
                .padding(.bottom, 0.5)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Beállítások")
                .font(.secondaryTitle)
            List {
                Section(header: sectionHeader(title: "Legutóbbi olvasás", subTitle: "")) {
                    HStack {
                        Text("Folytatás")
                            .font(.secondaryTitle)
                        Toggle("", isOn: $viewModel.saveLastPosition)
                    }
                    .padding()
                    Text("")
                        .padding(0)
                        
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                Section(header: sectionHeader(title: "Színkategóriák", subTitle: "(Érintsd meg a nevet)")) {
                    ForEach(colors.indices, id:\.self) { index in
                        HStack {
                            TextField(self.colors[index], text: self.$viewModel.titles[index])
                            .font(.secondaryTitle)
                            .padding()
                            Spacer()
                            Circle()
                                .fill(Color(self.colors[index]))
                                .frame(width: 32, height: 32)
                                .padding(.trailing)
                            
                        }
                        
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(.top, 32)
        }
        .onAppear {
            UITableView.appearance().tableFooterView = UIView()
//            UITableView.appearance().cellLayoutMarginsFollowReadableWidth = false
        }
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewModel: BibleViewModel())
    }
}
