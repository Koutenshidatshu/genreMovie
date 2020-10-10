//
//  MovieDetailViewController.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 10/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: Movie
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = movie.title
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
