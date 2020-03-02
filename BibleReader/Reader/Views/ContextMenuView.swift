//
//  ContextMenuView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 24..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

//var colors = ["yellow", "purple", "blue", "green", "gray"]
var colors = ["Yellow", "Red", "Blue", "Green", "Gray"]
struct ContextMenuView: View {
    @Binding var showContextMenu: Bool
    var vers: Versek!
    @ObservedObject var viewModel: BibleViewModel
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
                
                ForEach(colors.indices, id:\.self) { index in
                    Button(action: {
                        self.viewModel.markVers(self.vers, index: index)
                        withAnimation {
                            self.showContextMenu = false
                        }
                    }, label: {
                        Circle()
                            .fill(Color(colors[index]))
                    })
                    .frame(width: 44)
                }
                
                Button(action: {
                    self.viewModel.removeVersMarking(self.vers)
                    withAnimation {
                        self.showContextMenu = false
                    }
                }, label: {
                    ZStack {
                        Circle()
                            .stroke(Color.black)
                        Text("X")
                    }
                })                     
                .frame(width: 44, height: 44)
            
            }                        
        }
        .padding(4)
    }
    
}

//struct ContextMenuView_Previews: PreviewProvider {
//    var vers = Versek(szoveg: "Azután összegyűjtötte Mózes Izráel fiainak egész közösségét, és ezt mondta nekik: Ezek azok az igék, amelyekről azt parancsolta az ÚR, hogy meg kell tennetek:", hely: Hely(gepi: 10203500100, szep: "2Móz 35,1"))
//    static var previews: some View {
//        ContextMenuView(showContextMenu: .constant(true), viewModel: BibleViewModel()).previewLayout(.fixed(width: 370, height: 100))
//    }
//}
