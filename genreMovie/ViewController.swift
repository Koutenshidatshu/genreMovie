//
//  ViewController.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 09/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = GenreViewModelFactory.create()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingViewModel()
        
        
    }
    
    
    func bindingViewModel() {
        viewModel.genreList
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] _ in
//                self?.imageCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        viewModel.getGenre()
    }
    
    
}

