//
//  BodyView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct BodyView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @EnvironmentObject var settings: ChapterSettingsModel
    @ObservedObject var viewModel: BibleViewModel
    @Binding var hideBars: Bool
    @Binding var showContextMenu: Bool
    
    @State var selectedVers: Versek?
    
    
    var body: some View {
        ZStack(alignment: .trailing) {
            GeometryReader { geo in
                VStack {
                    ScrollView {
                        VStack {
                            self.chapterTitle
                                
                            if self.viewModel.versek.count > 0 {
                                VStack(alignment: .leading) {
                                    if self.settings.reading == .vers {
                                        self.lineByLineText
                                    } else {
                                        self.continuousText
                                            .onTapGesture {
                                                withAnimation(.easeInOut) {
                                                    self.hideBars.toggle()
                                                }
                                            }
                                    }
                                }
                                
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(width: self.calculateSize(width: geo.size.width))

            }
                        
            self.contextMenu(vers: self.selectedVers)
                .frame(width: 375, height: 65)
                .background(Color.white)
                .offset(x: self.showContextMenu ? 0 : UIScreen.main.bounds.width)
        }
    }
    
    
}

// MARK: - Subviews
extension BodyView {
    var chapterTitle: some View {
        VStack {
            Text(self.viewModel.book.name)
                .font(.custom("Fira Sans Bold", size: 30))
                .lineSpacing(1.4)
            Text("\(self.viewModel.chapter). fejezet")
                .font(.custom("Fira Sans Medium", size: 24))
                .lineSpacing(1.4)
                .allowsTightening(true)
        }
        .padding(.bottom, 32)
    }
    
    var lineByLineText: some View {
        ForEach(0..<self.viewModel.versek.count, id:\.self) { index in
            Group {
                if self.viewModel.versek[index].szoveg != nil {
                    Text(self.settings.showVerses ? "\(index + 1) " : "")
                        .font(self.settings.fontType.value)
                        .fontWeight(.bold)
                        + Text(self.viewModel.versek[index].szoveg!.removedHTMLTags)
                            .font(self.settings.fontType.value)
 
                }
            }
            .frame(maxWidth: .infinity, alignment: Alignment.leading)
            .background(self.getBackgroundColor(vers: self.viewModel.versek[index])?.opacity(0.4))
            .onTapGesture {
                withAnimation(.easeInOut) {
                    self.hideBars.toggle()
                }
            }
            .onLongPressGesture {
                withAnimation(.easeInOut) {
                    var vers = self.viewModel.versek[index]
                    vers.forditas = self.viewModel.translation.rawValue
                    self.selectedVers = vers
                    self.showContextMenu.toggle()
                }
            }
            .padding(.vertical, 3)
            .padding(.horizontal, 16)
            .lineSpacing(7)
            .allowsHitTesting(!self.showContextMenu)
        }
    }
    
    var continuousText: some View {
        var resultText = Text("")
            
        for index in viewModel.versek.indices{
            if self.viewModel.versek[index].szoveg != nil {
                let indexText = Text("\(index + 1) ")
                    .font(self.settings.fontType.value)
                    .fontWeight(.bold)
                if settings.showVerses {
                    resultText = resultText + indexText
                }
                let szovegText = Text("\(viewModel.versek[index].szoveg!.removedHTMLTags) ")
                    .font(self.settings.fontType.value)
                
                resultText = resultText + szovegText
            }
        }
        return resultText
            .padding(.vertical, 3)
            .padding(.horizontal, 16)
            .lineSpacing(7)
    }
    
    func contextMenu(vers: Versek!) -> some View {
        VStack {
            HStack(spacing: 10) {
                Button(action: {
                    withAnimation {
                        self.showContextMenu = false
                    }
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left")
                        .font(.title)
                })
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 1, height: 44)
                
                ForEach(colors.indices, id:\.self) { index in
                    Button(action: {
                        self.viewModel.markVers(vers, index: index)
                        withAnimation {
                            self.showContextMenu = false
                        }
                    }, label: {
                        Circle()
                            .fill(Color(colors[index]))
                    })
                    .frame(width: 44)
                }
                
                Button(action: {
                    self.viewModel.removeVersMarking(vers)
                    withAnimation {
                        self.showContextMenu = false
                    }
                }, label: {
                    ZStack {
                        Circle()
                            .stroke(Color.black)
                        Text("X")
                    }
                })
                .frame(width: 44, height: 44)
            }
        }
        .padding(4)
    }
}

// MARK: - Helpers
extension BodyView {
    
    func calculateSize(width: CGFloat) -> CGFloat {
        if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return width * 0.8
        }
        
        return width
    }
    
    func getBackgroundColor(vers: Versek) -> Color? {
        for index in colors.indices {
            if self.viewModel.favorites[index].contains(where: {$0.vers.hely.gepi == vers.hely.gepi}) {
                return Color(colors[index])
            }
        }
        
        return nil
    }
    
    func getContinuous() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "")
        for index in self.viewModel.versek.enumerated() {
            let indexFontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family: "Fira Sans Regular"])
            indexFontDescriptor.withSymbolicTraits(.traitBold)
            let szovegFontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family : "Fira Sans Regular"])
            attributedString.append(NSAttributedString(string: "\(index.offset )", attributes: [NSAttributedString.Key.font : UIFont(descriptor: indexFontDescriptor, size: settings.fontsize)]))
            attributedString.append(NSAttributedString(string: "\(self.viewModel.versek[index.offset].szoveg ?? "") ", attributes: [NSAttributedString.Key.font : UIFont(descriptor: szovegFontDescriptor, size: settings.fontsize)]))
        }
        
        return attributedString
    }
}


//struct BodyView_Preview: PreviewProvider {
//
//    static var previews: some View {
//        BodyView(title: "Mózes 2. könyve", subtitle: "35. fejezet", result: ChapterViewModel().result)
//    }
//}


