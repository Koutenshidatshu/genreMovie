//
//  MovieDetailResponse.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 10/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

struct MovieDetailRequester {
    enum RequestError : Error {
        case parse
    }
    let request: () -> Single<MovieDetailResponse>
}

extension MovieDetailRequester {
    init(requestApi: Observable<Data>) {
        request = {
            requestApi
                .map { try MovieDetailResponse.parse($0) }
                .take(1)
                .asSingle()
        }
    }
}

struct MovieDetailResponse : Decodable {
    let originalTitle : String
    let originalLanguage: String
    let overview: String
    let popularity: Float
    let posterPath: String?
    let releaseDate: String
    let status: String
    let tagline: String
    let backdropPath: String?
}



private extension MovieDetailResponse {
    static func decode(from data: Data) throws -> MovieDetailResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(MovieDetailResponse.self, from: data)
    }
    
    static func parse(_ jsonData: Data) throws -> MovieDetailResponse {
        do {
            return try decode(from: jsonData)
        } catch {
            throw MovieDetailRequester.RequestError.parse
        }
    }
}

