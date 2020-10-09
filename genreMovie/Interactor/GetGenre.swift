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
}

class GetGenreImpl: GetGenre {
    
    func get() -> Observable<Data> {
        let session = URLSession.shared
        let data = session.rx.response(request: requestUrl())
            .map { (_, data) in
                return data
        }.retry(2)
        return handleApiRequestFailed(data)
    }
    
    private func requestUrl() -> URLRequest {
        let id = "a243954956e6189b195474fdcb384a00"
        let url = URL(string: ApiPath().path + "genre/movie/list?api_key=\(id)&language=en-US")!
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
