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
    @State var redTitle = ""
    var colors = ["Yellow", "Red", "Blue", "Green", "Gray"]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Utolsóként olvasott szakasz")
                    .font(.secondaryTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                
                Toggle(isOn: $viewModel.saveLastPosition, label: {
                    Text("Folytatás")
                        .font(.normal)
                }).padding(.horizontal)
            }
            .padding(.bottom, 50)
            .background(TopRoundedShape(cornerRadius: 20).stroke(Color("Green"), lineWidth: 2).background(Color.white))
            
            
            VStack {
                Text("Színkategóriák elnevezése")
                    .font(.secondaryTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                ForEach(colors, id:\.self) { color in
                    HStack {
                        Circle()
                            .fill(Color(color))
                            .frame(width: 32, height: 32)
                        TextField(color, text: self.$redTitle)
                            .padding()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 50)
            .background(TopRoundedShape(cornerRadius: 20).stroke(Color("Blue"), lineWidth: 2).background(Color.white))
            .offset(x: 0, y: -30)
            
            TopRoundedShape(cornerRadius: 20).stroke(Color("Yellow"), lineWidth: 2)
                .background(Color.white)
                .offset(x: 0, y: -60)
            
            Spacer()
            Rectangle()
                .fill(Color.white)
                .edgesIgnoringSafeArea(.bottom)
                .offset(x: 0, y: -80)
        }
        .padding(.top)
        
        
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewModel: BibleViewModel())
    }
}
