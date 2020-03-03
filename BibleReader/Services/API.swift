//
//  API.swift
//  BibleReader
//
//  Created by Gabor Sornyei on 2020. 02. 20..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import Foundation
import Combine

class API {
    func createChapterURLComponents(forBook book: String, and chapter: Int, translation: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "szentiras.hu"
        components.path = "/api/idezet/\(book)\(chapter)/\(translation)"
        
        return components
    }
    
    func fetch(forBook book: Book, and chapter: Int, translation: String) -> AnyPublisher<ChapterResponse, BibleError> {
        
        if !Translation(rawValue: translation)!.hasBook(book.abbreviation) {
            return Fail(error: BibleError.translating(book.name)).eraseToAnyPublisher()
        }
        
        let urlComponents = createChapterURLComponents(forBook: book.abbreviation, and: chapter, translation: translation)
        
        guard let url = urlComponents.url else {
            return Fail(error: BibleError.parsing).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .tryMap({ (data, response) in
                if let httpResponse = response as? HTTPURLResponse, (200...300).contains(httpResponse.statusCode)  {
                    return data
                }
                throw BibleError.network
            })
            .decode(type: ChapterResponse.self, decoder: JSONDecoder())        
            .mapError({error -> BibleError in
                switch error {
                case is URLError:
                    return .network
                case is DecodingError:
                    return .parsing
                default:
                    return error as? BibleError ?? .unknown
                }
            })
            .eraseToAnyPublisher()
        
    }
}
