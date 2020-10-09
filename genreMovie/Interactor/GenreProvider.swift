//
//  GenreProvider.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 09/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift

protocol GenreProvider {
    func get() -> Observable<GenreListResponse>
}

struct GenreProviderImpl: GenreProvider {
    
    private let service: GetGenre
    
    init(service: GetGenre) {
        self.service = service
    }
    
    func get() -> Observable<GenreListResponse> {
        let requester = GenreRequester(requestApi: service.get())
        return requester.request().asObservable()
    }
}

struct GenreProviderFactory {
    static func create() -> GenreProvider {
        return GenreProviderImpl(service: GetGenreImpl())
    }
}

