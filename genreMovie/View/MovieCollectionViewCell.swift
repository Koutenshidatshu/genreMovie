//
//  MovieCollectionViewCell.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 10/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import Nuke

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(movie: Movie) {
        movieLabel.text = movie.title
        guard let posterPath = movie.posterPath else { return }
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath) else { return }
        loadImage(with: imageURL, into: posterImage)
    }

}
