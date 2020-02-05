//
//  ChapterViewModel.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 04..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI
import Combine

class ChapterViewModel: ObservableObject {
    
    @Published var result: Result?
    
    init() {
        let path = Bundle.main.url(forResource: "Example", withExtension: "json")!
        do {
            let data = try Data(contentsOf: path)            
            result = try JSONDecoder().decode(Result.self, from: data)            
        } catch {
            print("Error:", error)
        }
    }
}

struct Result: Codable {
    var keres: Keres
    var valasz: Valasz
}

struct Keres: Codable {
    var feladat: String
    var hivatkozas: String
    var forma: String
}

struct Valasz: Codable {
    var versek: [Vers]
    var forditas: Forditas
}

struct Forditas: Codable {
    var nev: String
    var rov: String
}
