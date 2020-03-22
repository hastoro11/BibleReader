//
//  UserSettingsView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 28..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @ObservedObject var viewModel: BibleViewModel
    @State var saveCurrent = false
    @Binding var showTutorial: Bool
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
        GeometryReader { geo in
            VStack(spacing: 0) {
                Text("Beállítások")
                    .font(.secondaryTitle)
                    
                List {
                    self.saveLastPosition
                    
                    self.categories
                    
                    self.showTutorialView
                }
                .frame(width: self.calculateSize(width: geo.size.width))
                .padding(.top, 32)
            }
            .padding(.top)
            .onAppear {
                UITableView.appearance().tableFooterView = UIView()
            }
        }
    }
}

// MARK: - Subviews
extension SettingView {
    var saveLastPosition: some View {
        Section(header: self.sectionHeader(title: "Legutóbbi olvasás", subTitle: "")) {
            HStack {
                Text("Folytatás")
                    .font(.secondaryTitle)
                Toggle("", isOn: self.$viewModel.saveLastPosition)
            }
            .padding()
            Text("")
                .padding(0)
                
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    var categories: some View {
        Section(header: self.sectionHeader(title: "Színkategóriák", subTitle: "(Érintsd meg a nevet)")) {
            ForEach(self.colors.indices, id:\.self) { index in
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
}

extension SettingView {
    var showTutorialView: some View {
        Section(header: self.sectionHeader(title: "Ismertető", subTitle: "")) {
            HStack {
                Button(action: {
                    self.showTutorial = true
                }, label: {
                    Text("Indítás")
                    .font(.secondaryTitle)
                })
            }
            .padding()
            
                
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

// MARK: - Helpers
extension SettingView {
    func calculateSize(width: CGFloat) -> CGFloat {
        if horizontalSizeClass == .regular {
            return width * 0.8
        }
        return width
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewModel: BibleViewModel(), showTutorial: .constant(false))
    }
}
