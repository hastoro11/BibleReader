//
//  BooksView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 07..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct BooksView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var books = Biblia_RUF.books
    var oldTestament = Biblia_RUF.books.filter({$0.covenant == .old}).chunks(6)
    var newTestament = Biblia_RUF.books.filter({$0.covenant == .new}).chunks(6)
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView {
                    VStack {
                        HStack {
                            Button(action: {}, label: {
                                InitialView(char: "B", color: Color("Blue"), size: 28)
                            })
                                        
                            VStack(alignment: .leading) {
                                Text("Magyar Bibliatársulat újfordítású Bibliája")
                                    .font(.smallTitle)
                                
                                Text("(Váltás)")
                                    .font(.smallTitle)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()

                        }
                        .padding(.leading)
                        .padding(.top, 10)
                        .padding(.bottom, 50)
                        .background(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
                        

                        ZStack {
                            Color("Yellow")
                                .cornerRadius(20)
                                
                            VStack {
                                HStack {
                                    InitialView(char: "Ó", color: Color("Green"), size: 28)
                                    Text("Ószövetség")
                                        .font(.secondaryTitle)
                                    Spacer()
                                }
                                .padding([.leading, .bottom, .top])
                                
                                VStack(alignment: .center, spacing: 10) {
                                    ForEach(self.oldTestament.indices, id:\.self) { chunk in
                                        HStack {
                                            ForEach(self.oldTestament[chunk], id:\.name) { book in
                                                Button(action: {}) {
                                                    Text(book.abbreviation)
                                                        .font(.secondaryTitle)
                                                        .frame(width: (geo.size.width - 60) / 6, height: 44)
                                                        .foregroundColor(.black)
                                                        .background(RoundedRectangle(cornerRadius: 2).stroke(Color("Green"), lineWidth: 3))
                                                        .background(Color("LightGray"))
                                                        .cornerRadius(2)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.bottom, 50)
                            }
                        }
                        .offset(x: 0, y: -50)
                        
                        ZStack {
                            
                            Color.white
                                .cornerRadius(20)
                            
                            VStack {
                                HStack {
                                    InitialView(char: "Ú", color: Color("Red"), size: 28)
                                    Text("Újszövetség")
                                        .font(.secondaryTitle)                                        
                                    Spacer()
                                }
                                .padding()
                                
                                VStack(alignment: .center, spacing: 10) {
                                    ForEach(self.newTestament.indices, id:\.self) { chunk in
                                        HStack {
                                            ForEach(self.newTestament[chunk], id:\.name) { book in
                                                Button(action: {}) {
                                                    Text(book.abbreviation)
                                                        .font(.secondaryTitle)
                                                        .frame(width: (geo.size.width - 60) / 6, height: 44)
                                                        .foregroundColor(.black)
                                                        
                                                        .background(RoundedRectangle(cornerRadius: 2).stroke(Color("Red"), lineWidth: 3))
                                                    .background(Color("LightGray"))
                                                        .cornerRadius(2)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.bottom)
                            }
                            
                            
                            
                            
                        }
                    .offset(x: 0, y: -100)
                        
                        
                    }.padding(.top, 3)
                    
                }
            }
            .padding(.top)
        }
        
    }
    
    init() {
        
    }
}


struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
