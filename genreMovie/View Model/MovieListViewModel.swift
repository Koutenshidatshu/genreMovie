//
//  MovieListViewModel.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 10/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieListViewModel {
    private let provider: MovieProvider
    private let disposeBag = DisposeBag()
    lazy var movieList: Observable<[Movie]> = movieListRelay.asObservable()
    private let movieListRelay = PublishRelay<[Movie]>()
    private var movies: [Movie] = [Movie]()
    
    init(provider: MovieProvider) {
        self.provider = provider
    }
    
    func discoverMovie(genreId: Int) {
        provider.getMovie(id: genreId)
            .subscribe(onNext: { [weak self] value in
                self?.movieListRelay.accept(value.results)
                self?.movies = value.results
                }, onError: { _ in print("@@@  error ")})
            .disposed(by: disposeBag)
    }
    
    func didSelectMovie(itemAt index: Int) -> Movie {
        return movies[index]
    }
}

struct MovieListViewModelFactory {
    static func create() -> MovieListViewModel {
        let provider = MovieProviderFactory.create()
        return MovieListViewModel(provider: provider)
    }
}
