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
    var colors = ["Yellow", "Red", "Blue", "Green", "Gray"]
    var ContinuousText: Text {
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
            
    }
    var body: some View {
        ZStack(alignment: .trailing) {
            GeometryReader { geo in
                VStack {
                    ScrollView {
                        VStack {
                            Text(self.viewModel.book.name)
                                .font(.custom("Fira Sans Bold", size: 30))
                                .lineSpacing(1.4)
                            Text("\(self.viewModel.chapter). fejezet")
                                .font(.custom("Fira Sans Medium", size: 24))
                                .lineSpacing(1.4)
                                .padding(.bottom, 32)
                                .allowsTightening(true)
                            if self.viewModel.versek.count > 0 {
                                VStack(alignment: .leading) {
                                    if self.settings.reading == .vers {
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
                                            .allowsHitTesting(!self.showContextMenu)
                                        }
                                        .padding(.bottom, 4)
                                        .padding(.horizontal, 20)
                                        .lineSpacing(9)
                                    } else {
                                        VStack {
                                            self.ContinuousText
                                                .lineSpacing(9)
                                                .padding(.bottom, 4)
                                                .padding(.horizontal, 20)
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
                        
            ContextMenuView(showContextMenu: self.$showContextMenu, vers: self.selectedVers, viewModel: self.viewModel)
                .frame(width: 375, height: 65)
                .background(Color.white)
                .offset(x: self.showContextMenu ? 0 : UIScreen.main.bounds.width)
        }
    }
    
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


