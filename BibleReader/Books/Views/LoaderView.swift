//
//  LoaderView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 21..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct LoaderView: UIViewRepresentable {
    var indicatorView = UIActivityIndicatorView()
    var isLoading: Bool
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        indicatorView.style = .large
        indicatorView.color = .white
        return indicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isLoading {
            indicatorView.startAnimating()
        } else {
            indicatorView.stopAnimating()
        }
    }
    
    typealias UIViewType = UIActivityIndicatorView

}
