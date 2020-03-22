//
//  PageScrollView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 03. 19..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI



struct PageScrollView: View {
    var pages = ["Books", "Chapters", "Translation_1", "Translation_2", "Readersview", "Fullpage", "Settings", "Marking", "Favs", "Context", "User"]
    var userSettingsService = UserSettingsService()
    @State var index = 0
    @Binding var showTutorial: Bool
    var body: some View {
        let showAtTheBeginning = Binding<Bool>(
            get: {
                return self.userSettingsService.getShowTutorialAtTheBeginning()
            }, set: { newValue in
                self.userSettingsService.setShowTutorialAtTheBeginning(value: newValue)
            }
        )
        return VStack {
            ZStack {
                Text("Ismertető")
                    .font(.secondaryTitle)
                HStack {
                    Spacer()
                    Button(action: {
                        self.showTutorial = false
                    }, label: {
                        Text("Bezár")
                            .font(.smallTitle)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.black)
                            .clipShape(Circle())
                    })
                }
            }
            SwipeView(pages: pages, index: $index)
            
            HStack {
                ForEach(self.pages.indices, id:\.self) {index in
                    Dot(isSelected: index == self.index)
                        .onTapGesture {
                            withAnimation {
                                self.index = index
                            }
                    }
                }
            }
            .frame(height: 64)
            
            HStack {
                
                Toggle(isOn: showAtTheBeginning, label: {
                    Text("Induláskor megjelenik")
                        .font(.secondaryTitle)
                })
            }
            .padding(.horizontal, 36)
        }
        .padding()
        .background(Color.white)
    }
}

struct Dot: View {
    var isSelected: Bool
    var body: some View {
        Circle()
            .fill(isSelected ? Color.black : Color.gray)
            .frame(width: 10, height: 10)
        
    }
}

struct PageScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PageScrollView(showTutorial: .constant(false))
    }
}
