//
//  Favorites.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 28..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
    var colors = ["Yellow", "Red", "Blue", "Green", "Gray"]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @ObservedObject var viewModel: BibleViewModel
    
    @Binding var selectedTab: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                VStack(spacing: 0) {
                    Text("Kedvencek")
                        .font(.secondaryTitle)
                        .padding(.bottom, 32)
                        .padding(.top)
                        
                    if !self.viewModel.isFavoritesEmpty {
                        List {
                            ForEach(self.colors.indices, id:\.self) { index in
                                Group {
                                    self.favorites(index: index)
                                }
                            }
                        }
                        .padding()
                        
                        .onAppear {
                            UITableView.appearance().backgroundColor = UIColor.white
                            UITableView.appearance().tableFooterView = UIView()
                        }
                    } else {
                        Text("Nincs elmentett kedvenced!")
                            .font(.tallBody)
                    }
                    Spacer()
                }
                .frame(width: self.calculateSize(width: geo.size.width))
            }
            
        }
    }
}

// MARK: - Subviews
extension FavoritesView {
    
    func favorites(index: Int) -> some View {
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
                            self.versBody(vers: favorite.vers, color: color)
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
                        .listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                        
                    }
                    .listRowBackground(Color.white)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                }
            }
        }
    
    func versBody(vers: Versek, color: String) -> some View {
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

// MARK: - Helpers
extension FavoritesView {
    func calculateSize(width: CGFloat) -> CGFloat {
        if horizontalSizeClass == .regular {
            return width * 0.8
        }        
        return width
    }
}
