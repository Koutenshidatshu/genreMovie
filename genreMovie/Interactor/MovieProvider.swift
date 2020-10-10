//
//  MovieProvider.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 10/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieProvider {
    func getMovie(id: Int) -> Observable<MovieResponse>
}

struct MovieProviderImpl: MovieProvider {
    
    private let service: GetGenre
    
    init(service: GetGenre) {
        self.service = service
    }
    
    func getMovie(id: Int) -> Observable<MovieResponse> {
        let requester = MovieRequester(requestApi: service.discoverGenre(id: id))
        return requester.request().asObservable()
    }
}

struct MovieProviderFactory {
    static func create() -> MovieProvider {
        return MovieProviderImpl(service: GetGenreImpl())
    }
}

