//
//  GenreListResponse.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 09/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//
import Foundation
import RxSwift

struct GenreRequester {
    enum RequestError : Error {
        case parse
    }
    let request: () -> Single<GenreListResponse>
}

extension GenreRequester {
    init(requestApi: Observable<Data>) {
        request = {
            requestApi
                .map { try GenreListResponse.parse($0) }
                .take(1)
                .asSingle()
        }
    }
}

struct GenreListResponse : Decodable {
    let genres : [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}


private extension GenreListResponse {
    static func decode(from data: Data) throws -> GenreListResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GenreListResponse.self, from: data)
    }
    
    static func parse(_ jsonData: Data) throws -> GenreListResponse {
        do {
            return try decode(from: jsonData)
        } catch {
            throw GenreRequester.RequestError.parse
        }
    }
}

