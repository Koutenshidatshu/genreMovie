//
//  MovieDetailViewController.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 10/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backDropImage: UIImageView!
    private let disposeBag = DisposeBag()
    private let viewModel = MovieDetailViewModelFactory.create()
    
    var movie: Movie
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title
        bindingViewModel()
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    func bindingViewModel() {
        viewModel.movieDetail
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] value in
                self?.setupDetail(movie: value)
            })
            .disposed(by: disposeBag)
        viewModel.detailMovie(movieId: movie.id)
    }
    
    private func setupDetail(movie: MovieDetailResponse) {
        titleLabel.text = movie.originalTitle
        descriptionLabel.text = movie.overview
        languageLabel.text = "Language: " + movie.originalLanguage
        statusLabel.text = "Status: " + movie.status
        tagLineLabel.text = "Tagline: " + movie.tagline

        
        guard let posterPath = movie.posterPath else {
                   return posterImage.image = Image(named: "placeholder")
               }
               guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath) else { return }
               let options = ImageLoadingOptions(
                   placeholder: UIImage(named: "placeholder"),
                   transition: .fadeIn(duration: 0.33)
               )
               
               loadImage(with: imageURL, options: options, into: posterImage, progress: .none,
                         completion: nil)
        
        
        guard let backDropPath = movie.backdropPath else { return }
        guard let backDropURL = URL(string: "https://image.tmdb.org/t/p/w500/" + backDropPath) else { return }
       
        loadImage(with: backDropURL, options: options, into: backDropImage, progress: .none,
        completion: nil)
        backDropImage.alpha = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
