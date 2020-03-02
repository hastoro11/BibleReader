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
            
            Text("Kedvencek")
                .font(.secondaryTitle)
                .padding(.bottom, 32)
            if !self.viewModel.isFavoritesEmpty {
                List {
                    ForEach(colors.indices, id:\.self) { index in
                        Group {
                            self.createFavorites(index: index)
                        }
                    }
                }
                .onAppear {
                    //                UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().backgroundColor = UIColor.white
                    UITableView.appearance().tableFooterView = UIView()
                }
            } else {
                Text("Nincs elmentett kedvenced!")
                    .font(.tallBody)
            }
            Spacer()
        }
    }
    
    func createFavorites(index: Int) -> some View {
        let favorites = viewModel.favorites[index]
        var title: String {
            return viewModel.titles[index]
        }
        let color = colors[index]
        return Group {
            if !favorites.isEmpty {
                Section(header: VStack(spacing: 0) {
                    HStack {
                        Text(title)
                            .font(.boldTitle)
                        Spacer()
                        Circle()
                            .fill(Color(color))
                            .frame(width: 32, height: 32)
                            .padding(.trailing)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white)
                    .padding(.bottom, 0.5)
                    }
                ) {
                    ForEach(favorites) { favorite in
                        VersBody(vers: favorite.vers, color: color)
                        .contextMenu(menuItems: {
                            Button(action: {
                                self.viewModel.jumpToChapter(favorite)
                                self.selectedTab = 1
                            }, label: {
                                Text("Ugrás a fejezethez")
                                Image(systemName: "arrow.turn.right.up")
                            })
                            
                            Button(action: {
                                self.viewModel.deleteFavorite(favorite)
                            }, label: {
                                Text("Törlés")
                                Image(systemName: "trash")
                            })
                        })
                    }
//                    .listRowBackground(Color(color).opacity(0.7))
                    .listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                }
                .listRowBackground(Color.white)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
            }
        }
    }
}

struct VersBody: View{
    var vers: Versek
    var color: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .firstTextBaseline) {
                Circle()
                    .fill(Color(color))
                    .frame(width: 12, height: 12)
                VStack(alignment: .leading) {
                    Text(vers.hely.szep)
                        .font(.secondaryTitle)
                    
                    Text(vers.szoveg?.removedHTMLTags ?? "")
                        .font(.smallBody)
                        
                }
                .padding(.leading, 4)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .bottom], 12)
    }
    
}
//
//struct Favorites_Previews: PreviewProvider {
//    static var previews: some View {
//        VersBody(vers: versek[0])
//    }
//}
