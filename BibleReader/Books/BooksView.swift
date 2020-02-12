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
    var oldTestament = Biblia_RUF.books.filter({$0.covenant == .old}).chunks(4)
    var newTestament = Biblia_RUF.books.filter({$0.covenant == .new}).chunks(4)
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Magyar Bibliatársulat újfordítású Bibliája (2014)")
                    .bold()
                    .font(.system(size: 18))
                    .padding(.vertical, 16)
                    .multilineTextAlignment(.center)
                    
                HStack {
                    Text("Ószövetség")
                        .font(.headline)
                    Spacer()
                }
                .padding(.bottom, 8)
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(0..<self.oldTestament.count, id:\.self) { chunk in
                        HStack(spacing: 0) {
                            ForEach(self.oldTestament[chunk], id:\.name) { book in
                                Group {
                                    Text(book.shortName)
                                        .font(.footnote)
                                        .padding(12)
                                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(UIColor.label)))
                                        .foregroundColor(Color(UIColor.systemBackground))
                                        .shadow(radius: 5)
                                        .padding(.trailing)
                                    
                                }
                                
                            }
                            Spacer()
                        }
                    }
                    
                }
                
                HStack {
                    Text("Újszövetség")
                        .font(.headline)
                    Spacer()
                }
                .padding(.vertical, 8)
                
                
                VStack(alignment:.leading, spacing: 8) {
                    
                    ForEach(0..<self.newTestament.count, id:\.self) { chunk in
                        HStack {
                            ForEach(self.newTestament[chunk], id:\.name) { book in
                                Group {
                                    if !(book.index + 1).isMultiple(of: 4) {
                                        Text(book.shortName)
                                            .border(Color.red)
                                        Spacer()
                                    } else {
                                        Text(book.shortName)
                                            .border(Color.red)
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
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
