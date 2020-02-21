//
//  BodyView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct BodyView: View {
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var viewModel: BibleViewModel
    var ContinuousText: Text {
        var resultText = Text("")            
        for index in viewModel.versek.enumerated() {
            let indexText = Text("\(index.offset + 1) ")
                .font(self.settings.fontType.value)
                .fontWeight(.bold)
            if settings.showVerses {
                resultText = resultText + indexText
            }
            let szovegText = Text("\(viewModel.versek[index.offset].szoveg.removedHTMLTags) ")
                .font(self.settings.fontType.value)
                
            resultText = resultText + szovegText
        }
        return resultText
            
    }
    var body: some View {
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
                    if self.viewModel.versek.count > 0 {
                        VStack(alignment: .leading) {
                            if settings.reading == .vers {
                                ForEach(0..<self.viewModel.versek.count, id:\.self) { index in
                                    Text(self.settings.showVerses ? "\(index + 1) " : "")
                                        .font(self.settings.fontType.value)
                                        .fontWeight(.bold)
                                        + Text(self.viewModel.versek[index].szoveg.removedHTMLTags)
                                            .font(self.settings.fontType.value)
                                }
                                .padding(.bottom, 4)
                                .padding(.horizontal, 20)
                                .lineSpacing(9)  
                            } else {
                                VStack {
                                    ContinuousText
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
        
    }
    
    func getContinuous() -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: "")
        for index in self.viewModel.versek.enumerated() {
            
            let indexFontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family: "Fira Sans Regular"])
            indexFontDescriptor.withSymbolicTraits(.traitBold)
            let szovegFontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family : "Fira Sans Regular"])
            attributedString.append(NSAttributedString(string: "\(index.offset )", attributes: [NSAttributedString.Key.font : UIFont(descriptor: indexFontDescriptor, size: settings.fontsize)]))
            attributedString.append(NSAttributedString(string: "\(self.viewModel.versek[index.offset].szoveg) ", attributes: [NSAttributedString.Key.font : UIFont(descriptor: szovegFontDescriptor, size: settings.fontsize)]))
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


