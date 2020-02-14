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
    var title: String
    var subtitle: String
    var result: Result
    var ContinuousText: Text {
        var resultText = Text("")            
        for index in result.valasz.versek.enumerated() {
            let indexText = Text("\(index.offset + 1) ")
                .font(self.settings.fontType.value)
                .fontWeight(.bold)
            if settings.showVerses {
                resultText = resultText + indexText
            }
            let szovegText = Text("\(result.valasz.versek[index.offset].szoveg) ")
                .font(self.settings.fontType.value)
                
            resultText = resultText + szovegText
        }
        return resultText
            
    }
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text(title)
                        .font(.custom("Fira Sans Bold", size: 30))
                        .lineSpacing(1.4)
                    Text(subtitle)
                        .font(.custom("Fira Sans Medium", size: 24))
                        .lineSpacing(1.4)
                        .padding(.bottom, 32)
                    if result.valasz.versek.count > 0 {
                        VStack(alignment: .leading) {
                            if settings.reading == .vers {
                                ForEach(0..<result.valasz.versek.count, id:\.self) { index in
                                    Text(self.settings.showVerses ? "\(index + 1) " : "")
                                        .font(self.settings.fontType.value)
                                        .fontWeight(.bold)
                                        + Text(self.result.valasz.versek[index].szoveg)
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
            }
        }
    }
    
    func getContinuous() -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: "")
        for index in result.valasz.versek.enumerated() {
            
            let indexFontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family: "Fira Sans Regular"])
            indexFontDescriptor.withSymbolicTraits(.traitBold)
            let szovegFontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family : "Fira Sans Regular"])
            attributedString.append(NSAttributedString(string: "\(index.offset )", attributes: [NSAttributedString.Key.font : UIFont(descriptor: indexFontDescriptor, size: settings.fontsize)]))
            attributedString.append(NSAttributedString(string: "\(result.valasz.versek[index.offset].szoveg) ", attributes: [NSAttributedString.Key.font : UIFont(descriptor: szovegFontDescriptor, size: settings.fontsize)]))
        }
        
        return attributedString
    }
}

struct BodyView_Preview: PreviewProvider {

    static var previews: some View {
        BodyView(title: "Mózes 2. könyve", subtitle: "35. fejezet", result: ChapterViewModel().result)
    }
}


