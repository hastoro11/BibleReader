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
    var viewModel: BibleViewModel
    @Binding var selectedTab: Int
    @State var showNumbersView = false
    @State var showTranslation = false
    
    var books = Biblia.books
    var oldTestament = Biblia.books.filter({$0.covenant == .old}).chunks(6)
    var newTestament = Biblia.books.filter({$0.covenant == .new}).chunks(6)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    ScrollView(.vertical, showsIndicators: false){
                        VStack {
                            HStack {
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        self.showTranslation.toggle()
                                    }
                                }, label: {
                                    InitialView(char: self.viewModel.translation.rawValue, color: self.viewModel.translation.color, size: 36)
                                })
                                
                                VStack(alignment: .leading) {
                                    Text(self.viewModel.translation.description)
                                        .font(.smallTitle)
                                    
                                    Text("(Váltás)")
                                        .font(.smallTitle)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding(.leading)
                            .padding(.top, 10)
                            .padding(.bottom, 35)
                            .background(TopRoundedShape(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
                            
                            VStack {
                                HStack {
                                    InitialView(char: "Ó", color: Color("Green"), size: 36)
                                    Text("Ószövetség")
                                        .font(.secondaryTitle)
                                    Spacer()
                                }
                                .padding([.leading, .bottom, .top])
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(self.oldTestament.indices, id:\.self) { chunk in
                                        HStack {
                                            ForEach(self.oldTestament[chunk], id:\.name) { book in
                                                Button(action: {
                                                    self.viewModel.book = book
                                                    self.showNumbersView = true
                                                }) {
                                                    BookButton(text: book.abbreviation, width: geo.size.width, color: Color("Green"))
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.bottom, 40)
                            }
                            .background(TopRoundedShape(cornerRadius: 20).fill(Color("Yellow")))
                            .offset(x: 0, y: -20)
                            
                            
                            
                            VStack {
                                HStack {
                                    InitialView(char: "Ú", color: Color("Red"), size: 36)
                                    Text("Újszövetség")
                                        .font(.secondaryTitle)
                                    Spacer()
                                }
                                .padding()
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(self.newTestament.indices, id:\.self) { chunk in
                                        HStack {
                                            ForEach(self.newTestament[chunk], id:\.name) { book in
                                                Button(action: {
                                                    self.viewModel.book = book
                                                    self.showNumbersView = true
                                                }) {
                                                    BookButton(text: book.abbreviation, width: geo.size.width, color: Color("Red"))
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                            .background(TopRoundedShape(cornerRadius: 20).fill(Color.white))
                        .offset(x: 0, y: -40)
                            
                            
                            
                        }.padding(.top, 3)
                        
                    }
                }
                .padding(.top)
            
                .sheet(isPresented: self.$showNumbersView) {
                    ChapterNumberView(selectedTab: self.$selectedTab, viewModel: self.viewModel)
                }
                
                VStack {
                    Spacer()
                    if self.showTranslation {
                        TranslationView(showTranslation: self.$showTranslation, viewModel: self.viewModel)
                            .frame(width: geo.size.width, height: self.horizontalSizeClass == .compact ? 220 : 220)
                            .transition(.move(edge: .bottom))
                    }
                }
            }
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


//struct BooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        BooksView()
//    }
//}
