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
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingViewModel()
        
        collectionView
            .register(UINib.init(nibName: "GenreCollectionViewCell", bundle: nil),
                      forCellWithReuseIdentifier: "genreCell")
        
    }
    
    
    func bindingViewModel() {
        viewModel.genreList
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        viewModel.getGenre()
        
        viewModel.genreList
            .asDriver(onErrorDriveWith: .empty())
            .drive(collectionView.rx.items(cellIdentifier: "genreCell",
                                           cellType: GenreCollectionViewCell.self))
            {  _, item, cell in cell.setup(genre: item) }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
        .map { $0.row }
        .bind(onNext: { [weak self] selectedItems in
//            let vc = GenreViewController()
//            guard let selected = self?.viewModel.didSelect(at: selectedItems) else { return }
//            vc.genre = selected
//            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
}

