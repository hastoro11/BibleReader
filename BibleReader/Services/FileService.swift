//
//  FileService.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 28..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation

class FileService {
    var colors = ["Yellow", "Red", "Blue", "Green", "Gray"]
    
    func saveFiles(lists: [[Versek]]) {
        for index in colors.indices {
            guard let fileUrl = self.getUrl(forFile: colors[index]) else {return}
            do {
                let data = try JSONEncoder().encode(lists[index])
                try data.write(to: fileUrl)
            } catch {
                fatalError("Error saving \(colors[index]): \(error.localizedDescription)")
            }
        }
    }
    
    func loadFiles() -> [[Versek]] {
        var lists = [[Versek]]()
        for index in colors.indices {
            guard let fileUrl = self.getUrl(forFile: colors[index]) else {return [[]]}
            do {
                let data = try Data(contentsOf: fileUrl)
                if !data.isEmpty {
                    let versek = try JSONDecoder().decode([Versek].self, from: data)
                    lists.insert(versek, at: index)
                } else {
                    lists.insert([], at: index)
                }
                 
            } catch {
                fatalError("Error loading \(colors[index]): \(error.localizedDescription)")
            }
        }
        return lists
    }
    
    private func getUrl(forFile file: String) -> URL? {
           
           let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
           print(documents)
           let fileUrl = documents
               .appendingPathComponent(file.capitalized)
               .appendingPathExtension("json")
           
           if !FileManager.default.fileExists(atPath: fileUrl.path) {
               FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
           }
           
           return fileUrl
       }
}
