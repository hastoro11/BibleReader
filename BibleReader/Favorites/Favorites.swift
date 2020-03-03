//
//  Favorites.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 28..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

//
//var versek = [
//    Versek(szoveg: "Mózesnek, az ÚR szolgájának halála után ezt mondta az ÚR Józsuénak, Nún fiának, Mózes szolgájának:", hely: Hely(gepi: 10600100100, szep: "Józs 1,1")),
//    Versek(szoveg: "Mózes, az én szolgám meghalt. Most azért indulj, kelj át itt a Jordánon, te és ez az egész nép arra a földre, amelyet Izráel fiainak adok.", hely: Hely(gepi: 10600100200, szep: "Józs 1,2")),
//    Versek(szoveg: "Nektek adok minden helyet, amelyre lábatokkal léptek, ahogyan megígértem Mózesnek.", hely: Hely(gepi: 10600100300, szep: "Józs 1,3")),
//    Versek(szoveg: "A pusztától és a Libánontól a nagy folyamig, az Eufrátesz folyamig, nyugat felé pedig a Nagy-tengerig a ti területetek lesz a hettiták egész országa.", hely: Hely(gepi: 10600100400, szep: "Józs 1,4")),
//    Versek(szoveg: "Senki sem állhat ellened egész életedben. Veled leszek, ahogyan Mózessel is vele voltam. Nem hagylak magadra téged, és nem hagylak el.", hely: Hely(gepi: 10600100500, szep: "Józs 1,5"))
//]

struct FavoritesView: View {
    var colors = ["Yellow", "Red", "Blue", "Green", "Gray"]    
    @ObservedObject var viewModel: BibleViewModel
    @Binding var selectedTab: Int
    var body: some View {
        VStack(spacing: 0) {
        
            HStack {
                Text("Kedvencek")
                    .font(.secondaryTitle)
                    .padding(.leading)
                Spacer()
            }
            .foregroundColor(.white)
            .frame(height: 50)
            .background(TopRoundedShape(cornerRadius: 12).fill(Color.black))
            .padding(.top)
            
            List {
                ForEach(colors.indices, id:\.self) { index in
                    self.createList(color: self.colors[index])
                }
                
            }
            .listStyle(PlainListStyle())
            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
        }
    }
    
    func createFavorites(index: Int) -> some View {
        var favorites = [Favorite]
    }
    
    func createList(color: String) -> some View {
        var list: [Versek] {
            switch color {
            case "Yellow":
                return viewModel.yellows
            case "Red":
                return viewModel.reds
            case "Blue":
                return viewModel.blues
            case "Green":
                return viewModel.greens
            case "Gray":
                return viewModel.grays
            default:
                return []
            }
        }
        var title: String {
            if let index = colors.firstIndex(of: color) {
                return viewModel.titles[index]
            }
            
            return color
        }
        return Group {
            if !list.isEmpty {
                Section(header: Header(title: title, color: color)) {
                    ForEach(list) { vers in
                        VersBody(vers: vers)
                        .contextMenu(menuItems: {
                            Button(action: {
                                self.viewModel.jumpToChapter(vers)
                                self.selectedTab = 1
                            }, label: {
                                Text("Ugrás a fejezethez")
                                Image(systemName: "arrow.turn.right.up")
                            })
                            
                            Button(action: {}, label: {
                                Text("Törlés")
                                Image(systemName: "trash")
                            })
                        })
                    }
                    .listRowBackground(Color(color).opacity(0.7))
                    .listRowInsets(.none)
                }
            }
        }
        
    }    
}

struct Header: View {
    var title: String
    var color: String
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.boldTitle)
                    .foregroundColor(.white)
                    .padding(.leading)
                    .frame(height: 50)
                Spacer()
            }
            .background(Color(color))
            .background(Color.white)
            Rectangle()
                .fill(Color.black)
                .frame(width: UIScreen.main.bounds.width, height: 1)
        }
    }
}

struct VersBody: View{
    var vers: Versek
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Circle()
                    .fill(Color("LightGray"))
                    .frame(width: 16, height: 16)
                VStack(alignment: .leading) {
                    Text(vers.hely.szep)
                        .font(.secondaryTitle)
                    
                    Text(vers.szoveg)
                        .font(.normal)
                        
                }
                .padding(.leading, 4)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .bottom], 8)
    }
    
}
//
//struct Favorites_Previews: PreviewProvider {
//    static var previews: some View {
//        VersBody(vers: versek[0])
//    }
//}
