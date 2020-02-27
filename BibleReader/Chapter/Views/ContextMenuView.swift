//
//  ContextMenuView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 24..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct ContextMenuView: View {
    @Binding var showContextMenu: Bool
    var colors = [Color("P_Yellow"), Color("P_Purple"), Color("P_Blue"), Color("P_Green")]
    var body: some View {        
        VStack {
            HStack(spacing: 10) {
                Button(action: {
                    withAnimation {
                        self.showContextMenu = false
                    }
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left")
                        .font(.title)
                })
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 1, height: 44)
                
                ForEach(colors, id:\.self) { color in
                    Button(action: {}, label: {
                        Circle()
                        .fill(color)
                    })
                    .frame(width: 44)
                }
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 1, height: 44)
                
                Button(action: {
                }, label: {
                    Image(systemName: "star")
                        .font(.title)
                })                
            }                        
        }
        .padding(4)
    }
    
}

struct ContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuView(showContextMenu: .constant(true)).previewLayout(.fixed(width: 350, height: 100))
    }
}
