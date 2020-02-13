//
//  BooksView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 07..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

var colors = [
    Color("Pale Gold"),
    Color("Grullo"),
    Color("Artichoke"),
    Color("Granite Gray"),
    Color("Outer Space")
]

struct BooksView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var height: CGFloat = 50
    var books = Biblia_RUF.books
    var oldTestament = Biblia_RUF.books.filter({$0.covenant == .old}).chunks(6)
    var newTestament = Biblia_RUF.books.filter({$0.covenant == .new}).chunks(6)
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    HStack {
                        Button(action: {}, label: {
                            InitialView(char: "B", color: .black)
                        })
                        
                        Text("Magyar Bibliatársulat újfordítású Bibliája (2014)")
                            .font(.secondaryTitle)
                            .multilineTextAlignment(.center)
                    }
                        
                   Divider()
                    
                    HStack {
                        InitialView(char: "Ó", color: Color("Blue"))
                        Text("Ószövetség")
                            .font(.secondaryTitle)
                        Spacer()
                    }
                    .padding([.leading, .bottom])
                    
                    VStack(alignment: .center, spacing: 10) {
                        ForEach(self.oldTestament.indices, id:\.self) { chunk in
                            HStack {
                                ForEach(self.oldTestament[chunk], id:\.name) { book in
                                    Button(action: {}) {
                                        Text(book.abbreviation)
                                            .font(.secondaryTitle)
                                            .frame(width: (geo.size.width - 60) / 6, height: 44)
                                            .foregroundColor(.black)
                                            .background(Color.black.opacity(0.1))
                                            .background(RoundedRectangle(cornerRadius: 2).stroke(Color("Blue"), lineWidth: 2))
                                            .cornerRadius(2)
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        InitialView(char: "Ú", color: Color("Red"))
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
                                            .background(Color.black.opacity(0.1))
                                            .background(RoundedRectangle(cornerRadius: 2).stroke(Color("Red"), lineWidth: 2))
                                            .cornerRadius(2)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                }
                
            }
        }
        
    }
    
    init() {
        
    }
}

struct InitialView: View {
    var char: String
    var color: Color
    var body: some View {
        Text(char)
            .foregroundColor(.white)
            .font(.secondaryTitle)
            .frame(width: 28, height: 28)
            .background(Circle().fill(color))
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
