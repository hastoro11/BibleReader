//
//  CollectionView.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 07..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import UIKit

struct CollectionView: UIViewRepresentable {
    typealias UIViewType = UICollectionView
    var books = Biblia_RUF.books
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return .init(width: 120, height: 50)
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return parent.books.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = parent.books[indexPath.item].shortName
            cell.addSubview(label)
            label.centerYAnchor.constraint(equalToSystemSpacingBelow: cell.centerYAnchor, multiplier: 0).isActive = true
            label.centerXAnchor.constraint(equalToSystemSpacingAfter: cell.centerXAnchor, multiplier: 0).isActive = true
            cell.backgroundColor = .cyan
            
            return cell
        }
        
        let parent: CollectionView
        
        init(_ parent: CollectionView) {
            self.parent = parent
        }
    }
    
    
}
