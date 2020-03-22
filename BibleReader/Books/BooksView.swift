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
            ZStack {
                Color("LightGray")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ScrollView(.vertical, showsIndicators: false){
                        VStack {
                            ZStack(alignment: .topTrailing) {
                                VStack(alignment: .center, spacing: 0) {
                                    self.translationHeader(width: geo.size.width)
                                    
                                    self.booksList(text: "Ószövetség",
                                                   color: Color("Green"),
                                                   width: self.calculateSize(width: geo.size.width),
                                                   books: self.oldTestament,
                                                   background: Color("Yellow"),
                                                   image: "beach-water-steps-sand")
                                    
                                    self.booksList(text: "Újszövetség",
                                                   color: Color("Red"),
                                                   width: self.calculateSize(width: geo.size.width),
                                                   books: self.newTestament,
                                                   background: Color("Green"),
                                                   image: "wave")
                                    
                                }
                                .padding()
                                
                                self.translationButton
                            }
                        }
                    }
                    .frame(width: geo.size.width)

                    
                }.padding(.top, 2)
                
                VStack {
                    Spacer()
                    if self.showTranslation {
                        TranslationView(showTranslation: self.$showTranslation, viewModel: self.viewModel, selectedTab: self.selectedTab)
                            .frame(width: geo.size.width, height: self.horizontalSizeClass == .compact ? 250 : 250)
                            .transition(.move(edge: .bottom))
                    }
                }
            }
            .sheet(isPresented: self.$showNumbersView) {
                ChapterNumberView(selectedTab: self.$selectedTab, viewModel: self.viewModel)
            }
        }
    }
}

// MARK: - Subviews
extension BooksView {
    func booksList(text: String, color: Color, width: CGFloat, books: [[Book]], background: Color, image: String) -> some View {
        ZStack {
            
            VStack {
                HStack {
                    InitialView(char: String(text.prefix(1)), color: color, size: 36)
                    Text(text)
                        .font(.secondaryTitle)
                    Spacer()
                }
                .frame(width: width - 40)
                .padding([.leading, .bottom, .top])
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(books.indices, id:\.self) { chunk in
                        HStack {
                            ForEach(books[chunk], id:\.name) { book in
                                Button(action: {
                                    self.viewModel.book = book
                                    self.showNumbersView = true
                                }, label: {
                                    self.bookButtonText(text: book.abbreviation, width: width, color: color)
                                })
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.bottom)
        }
    }
    
    func bookButtonText(text: String, width: CGFloat, color: Color) -> some View {
        Text(String(text.prefix(6)))
            .font(.secondaryTitle)
            .frame(width: (width - 100) / 6, height: 44)
            .foregroundColor(.black)
            
            .background(RoundedRectangle(cornerRadius: 2).stroke(color, lineWidth: 3))
            .background(Color("LightGray"))
            .cornerRadius(2)
    }
    
    func translationHeader(width: CGFloat) -> some View {
        HStack {
            Text(self.viewModel.translation.description)
                .font(.secondaryTitle)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .frame(width: width * 0.65, height: 44)
    }
    
    var translationButton: some View {
        HStack {
            Button(action: {
                self.showTranslation.toggle()
            }) {
                Text(self.viewModel.translation.rawValue)
                    .font(.boldTitle)
                    .background(Circle().fill(self.viewModel.translation.color).frame(width: 54, height: 54))
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
            .shadow(radius: 3)
        }
        .frame(height: 65)
        .padding(.trailing, 25)
        .padding(.top, 27)
    }
}

// MARK: - Helpers
extension BooksView {
    func calculateSize(width: CGFloat) -> CGFloat {
        if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return width * 0.8
        }
        return width
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

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(showTranslation: .constant(false), viewModel: BibleViewModel(), selectedTab: 0)
    }
}
