//
//  MovieResponse.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 10/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

struct MovieRequester {
    enum RequestError : Error {
        case parse
    }
    let request: () -> Single<MovieResponse>
}

extension MovieRequester {
    init(requestApi: Observable<Data>) {
        request = {
            requestApi
                .map { try MovieResponse.parse($0) }
                .take(1)
                .asSingle()
        }
    }
}

struct MovieResponse : Decodable {
    let results : [Movie]
}

struct Movie: Decodable {
    let posterPath: String?
    let id: Int
    let title: String
}


private extension MovieResponse {
    static func decode(from data: Data) throws -> MovieResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(MovieResponse.self, from: data)
    }
    
    static func parse(_ jsonData: Data) throws -> MovieResponse {
        do {
            return try decode(from: jsonData)
        } catch {
            throw MovieRequester.RequestError.parse
        }
    }
}

