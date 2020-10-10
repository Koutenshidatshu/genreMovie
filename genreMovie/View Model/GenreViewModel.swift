//
//  GenreViewModel.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 09/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GenreViewModel {
    private let provider: GenreProvider
    private let disposeBag = DisposeBag()
    lazy var genreList: Observable<[Genre]> = genreListRelay.asObservable()
    private let genreListRelay = PublishRelay<[Genre]>()
    private var genres: [Genre] = [Genre]()
    
    init(provider: GenreProvider) {
        self.provider = provider
    }
    
    func getGenre() {
        provider.get()
            .subscribe(onNext: { [weak self] value in
                self?.genreListRelay.accept(value.genres)
                self?.genres = value.genres
                }, onError: { _ in print("@@@  error ")})
            .disposed(by: disposeBag)
    }
    
    func didSelectGenre(itemAt index: Int) -> Genre {
        return genres[index]
    }
}

struct GenreViewModelFactory {
    static func create() -> GenreViewModel {
        let provider = GenreProviderFactory.create()
        return GenreViewModel(provider: provider)
    }
}
