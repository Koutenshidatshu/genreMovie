//
//  MovieDetailProvider.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 10/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieDetailProvider {
    func getDetail(id: Int) -> Observable<MovieDetailResponse>
}

struct MovieDetailProviderImpl: MovieDetailProvider {
    
    private let service: GetGenre
    
    init(service: GetGenre) {
        self.service = service
    }
    
    func getDetail(id: Int) -> Observable<MovieDetailResponse> {
        let requester = MovieDetailRequester(requestApi: service.getDetail(movieId: id))
        return requester.request().asObservable()
    }
}

struct MovieDetailProviderFactory {
    static func create() -> MovieDetailProvider {
        return MovieDetailProviderImpl(service: GetGenreImpl())
    }
}

