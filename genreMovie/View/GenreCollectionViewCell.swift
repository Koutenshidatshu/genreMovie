//
//  GenreCollectionViewCell.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 09/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setup(genre: Genre) {
        nameLabel.text = genre.name
    }
}
