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
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var viewModel: BibleViewModel
    @Binding var selectedTab: Int
    @State var showNumbersView = false
    @State var showTranslation = false
    
    var oldTestament: [[Book]] {
        return viewModel.translation.books.filter({$0.covenant == .old}).chunks(6)
    }
    var newTestament: [[Book]] {
        return viewModel.translation.books.filter({$0.covenant == .new}).chunks(6)
    }
    
    var body: some View {
        GeometryReader { geo in
            
                VStack(alignment: .center) {
                    Text("Könyvek")
                        .font(.secondaryTitle)
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .center) {
                            
                            TranslationButton(
                                translation: self.viewModel.translation,
                                tapOnTitle: {
                                    self.showTranslation.toggle()
                                })
                                .padding(.leading)
                                .padding(.top, 10)
                                .padding(.bottom, 35)
                                .frame(width: self.calculateSize(width: geo.size.width))
                                .background(TopRoundedShape(cornerRadius: 20).fill(Color.white))


                            BookList(text: "Ószövetség", width: geo.size.width * (self.horizontalSizeClass == .regular ? 0.8 : 1.0), color: Color("Green"), books: self.oldTestament, tapOnBook: self.tapOnBook(book:))
                                .background(TopRoundedShape(cornerRadius: 20).fill(Color("Yellow")))
                                .offset(x: 0, y: -20)


                            BookList(text: "Újszövetség", width: geo.size.width * (self.horizontalSizeClass == .regular ? 0.8 : 1.0), color: Color("Red"), books: self.newTestament, tapOnBook: self.tapOnBook(book:))

                                .background(TopRoundedShape(cornerRadius: 20).fill(Color.white))
                                .offset(x: 0, y: -40)
                        }
                        .padding(.top, 3)
                        
                    }
                    .background(TopRoundedShape(cornerRadius: 20).stroke(Color("Yellow"), lineWidth: 1))
                }
                .frame(width: geo.size.width)
                .padding(.top)
                .sheet(isPresented: self.$showNumbersView) {
                    ChapterNumberView(selectedTab: self.$selectedTab, viewModel: self.viewModel)
                }
            
            
            
            VStack {
                Spacer()
                if self.showTranslation {
                    TranslationView(showTranslation: self.$showTranslation, viewModel: self.viewModel, selectedTab: self.selectedTab)
                        .frame(width: geo.size.width, height: self.horizontalSizeClass == .compact ? 250 : 250)
                        .transition(.move(edge: .bottom))
                }
            }
            
            
        }
        
    }
    
    func calculateSize(width: CGFloat) -> CGFloat {
        if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return width * 0.8
        }
        
        return width
    }
    
    func tapOnBook(book: Book) {
        viewModel.book = book
        showNumbersView = true
    }
    
}

struct TranslationButton: View {
    var translation: Translation
    var tapOnTitle: () -> Void
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                self.tapOnTitle()
            }
        }, label: {
            HStack {
                InitialView(char: self.translation.rawValue, color: self.translation.color, size: 36)
                
                VStack(alignment: .leading) {
                    Text(self.translation.description)
                        .font(.smallTitle)
                    
                    Text("(Váltás)")
                        .font(.smallTitle)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        })
    }
}

struct BookList: View {
    var text: String
    var width: CGFloat
    var color: Color
    var books: [[Book]]
    var tapOnBook: (Book) -> Void
    var body: some View {
        VStack {
            HStack {
                InitialView(char: String(text.prefix(1)), color: color, size: 36)
                Text(text)
                    .font(.secondaryTitle)
                Spacer()
            }
            .frame(width: width)
            .padding([.leading, .bottom, .top])
            
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(self.books.indices, id:\.self) { chunk in
                    HStack {
                        ForEach(self.books[chunk], id:\.name) { book in
                            Button(action: {
                                self.tapOnBook(book)
                            }) {
                                BookButton(text: book.abbreviation, width: self.width, color: self.color)
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 40)
        }
    }
}

struct BookButton: View {
    var text: String
    var width: CGFloat
    var color: Color
    var body: some View {
        Text(String(text.prefix(6)))
            .font(.secondaryTitle)
            .frame(width: (width - 60) / 6, height: 44)
            .foregroundColor(.black)
            
            .background(RoundedRectangle(cornerRadius: 2).stroke(color, lineWidth: 3))
            .background(Color("LightGray"))
            .cornerRadius(2)
    }
}


struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(showTranslation: .constant(false), viewModel: BibleViewModel(), selectedTab: 0)
    }
}
