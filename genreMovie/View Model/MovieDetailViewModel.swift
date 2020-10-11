//
//  MovieDetailViewModel.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 10/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    private let provider: MovieDetailProvider
    private let disposeBag = DisposeBag()
    lazy var movieDetail: Observable<MovieDetailResponse> = movieDetailRelay.asObservable()
    private let movieDetailRelay = PublishRelay<MovieDetailResponse>()
    
    
    init(provider: MovieDetailProvider) {
        self.provider = provider
    }
    
    func detailMovie(movieId: Int) {
        provider.getDetail(id: movieId)
            .subscribe(onNext: { [weak self] value in
                self?.movieDetailRelay.accept(value)
                }, onError: { _ in print("@@@  error ")})
            .disposed(by: disposeBag)
    }
}

struct MovieDetailViewModelFactory {
    static func create() -> MovieDetailViewModel {
        let provider = MovieDetailProviderFactory.create()
        return MovieDetailViewModel(provider: provider)
    }
}
