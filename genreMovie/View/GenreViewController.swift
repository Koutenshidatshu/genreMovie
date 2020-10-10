//
//  GenreViewController.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 09/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    var genre: Genre?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = genre?.name ?? ""
    }
}
