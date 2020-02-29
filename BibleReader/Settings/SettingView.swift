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
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("Utolsóként olvasott szakasz")
                    .font(.secondaryTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: UIScreen.main.bounds.width, height: 1)
                    
                
                Toggle(isOn: $viewModel.saveLastPosition, label: {
                    Text("Folytatás")
                        .font(.smallBody)
                }).padding(.horizontal)
            }
            .padding(.bottom, 50)
            .background(TopRoundedShape(cornerRadius: 20).stroke(Color.black, lineWidth: 0.5))
            .background(TopRoundedShape(cornerRadius: 20).fill(Color("Opaque_Yellow").opacity(0.7)))
            
            
            VStack {
                Text("Színkategóriák elnevezése")
                    .font(.secondaryTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                
                Rectangle()
                .fill(Color.black)
                .frame(width: UIScreen.main.bounds.width, height: 1)
                
                ForEach(colors.indices, id:\.self) { index in
                    HStack {
                        Circle()
                            .fill(Color(self.colors[index]))
                            .frame(width: 32, height: 32)
                        TextField(self.colors[index], text: self.$viewModel.titles[index])
                            .font(.smallBody)
                            .padding()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 50)
            .background(TopRoundedShape(cornerRadius: 20).fill(Color("Opaque_Red")))
            .background(TopRoundedShape(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
            .offset(x: 0, y: -25)
            
            Color.white
                .clipShape(TopRoundedShape(cornerRadius: 20))
                .background(TopRoundedShape(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
                .padding(.top, -50)

        }
        .padding(.top)
        
        
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewModel: BibleViewModel())
    }
}
