//
//  Favorites.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 28..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI


var versek = [
    Versek(szoveg: "Mózesnek, az ÚR szolgájának halála után ezt mondta az ÚR Józsuénak, Nún fiának, Mózes szolgájának:", hely: Hely(gepi: 10600100100, szep: "Józs 1,1")),
    Versek(szoveg: "Mózes, az én szolgám meghalt. Most azért indulj, kelj át itt a Jordánon, te és ez az egész nép arra a földre, amelyet Izráel fiainak adok.", hely: Hely(gepi: 10600100200, szep: "Józs 1,2")),
    Versek(szoveg: "Nektek adok minden helyet, amelyre lábatokkal léptek, ahogyan megígértem Mózesnek.", hely: Hely(gepi: 10600100300, szep: "Józs 1,3")),
    Versek(szoveg: "A pusztától és a Libánontól a nagy folyamig, az Eufrátesz folyamig, nyugat felé pedig a Nagy-tengerig a ti területetek lesz a hettiták egész országa.", hely: Hely(gepi: 10600100400, szep: "Józs 1,4")),
    Versek(szoveg: "Senki sem állhat ellened egész életedben. Veled leszek, ahogyan Mózessel is vele voltam. Nem hagylak magadra téged, és nem hagylak el.", hely: Hely(gepi: 10600100500, szep: "Józs 1,5"))
]

struct Favorites: View {
    var body: some View {
        
        List {
            Section(header: Header(title: "Red", color: "Red")) {
                ForEach(versek) { vers in
                    VersBody(vers: vers)
                }
            }
            Section(header: Header(title: "Blue", color: "Blue")) {
                ForEach(versek) { vers in
                    VersBody(vers: vers)
                }
            }
            
            
            
        }
        .listStyle(PlainListStyle())
        .padding(.top)
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }
    
}

struct Header: View {
    var title: String
    var color: String
    var body: some View {
        Text(title)
            .font(.boldTitle)
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
            .background(TopRoundedShape(cornerRadius: 20).fill(Color(color)))
            .background(Color.white)
            
        
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
                        .font(.body)
                        
                }
                .padding(.leading, 4)
            }
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
