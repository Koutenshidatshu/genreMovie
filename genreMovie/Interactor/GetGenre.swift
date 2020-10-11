//
//  GetGenre.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 09/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
//https://api.themoviedb.org/3/genre/movie/list?api_key=<<api_key>>&language=en-US
protocol GetGenre {
    func get() -> Observable<Data>
    func discoverGenre(id: Int) -> Observable<Data>
    func getDetail(movieId: Int) -> Observable<Data>
}

class GetGenreImpl: GetGenre {
    private let apiKey = "a243954956e6189b195474fdcb384a00"
    func get() -> Observable<Data> {
        let session = URLSession.shared
        let data = session.rx.response(request: requestUrl())
            .map { (_, data) in
                return data
        }.retry(2)
        return handleApiRequestFailed(data)
    }
    
    func discoverGenre(id: Int) -> Observable<Data> {
        let session = URLSession.shared
        let data = session.rx.response(request: requestDiscoverUrl(id: id))
            .map { (_, data) in
                return data
        }.retry(2)
        return handleApiRequestFailed(data)
    }
    
    func getDetail(movieId: Int) -> Observable<Data> {
        let session = URLSession.shared
        let data = session.rx.response(request: requestMovieDetailUrl(id: movieId))
            .map { (_, data) in
                return data
        }.retry(2)
        return handleApiRequestFailed(data)
    }
    
    private func requestUrl() -> URLRequest {
        let url = URL(string: ApiPath().path + "genre/movie/list?api_key=\(apiKey)&language=en-US")!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    private func requestDiscoverUrl(id: Int) -> URLRequest {
        
        let url = URL(string: ApiPath().path + "discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(id)")!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        return urlRequest
    
    }
    
    private func requestMovieDetailUrl(id: Int) -> URLRequest {
        
        let url = URL(string: ApiPath().path + "movie/\(id)?api_key=\(apiKey)&language=en-US")!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        return urlRequest
    
    }
    
    private func handleApiRequestFailed(_ observable: Observable<Data>) -> Observable<Data> {
        return observable.catchError { error -> Observable<Data> in
            if case let .httpRequestFailed(_, data)? = error as? RxCocoaURLError {
                return Observable.from(optional: data)
            } else {
                return .error(error)
            }
        }
    }
    
}
