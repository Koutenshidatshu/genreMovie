//
//  GenreViewController.swift
//  genreMovie
//
//  Created by Yonathan Wijaya on 09/10/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class GenreViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    private let viewModel = MovieListViewModelFactory.create()
    var genre: Genre?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = genre?.name ?? ""
        bindingViewModel()
        
        movieCollectionView
        .register(UINib.init(nibName: "MovieCollectionViewCell", bundle: nil),
                  forCellWithReuseIdentifier: "movieCell")
    }
    
    func bindingViewModel() {
        viewModel.movieList
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] _ in
                self?.movieCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        viewModel.discoverMovie(genreId: genre?.id ?? 0)
        
        viewModel.movieList
            .asDriver(onErrorDriveWith: .empty())
            .drive(movieCollectionView.rx.items(cellIdentifier: "movieCell",
                                           cellType: MovieCollectionViewCell.self))
            {  _, item, cell in cell.setup(movie: item) }
            .disposed(by: disposeBag)
        
//
//        movieCollectionView.rx.itemSelected
//        .map { $0.row }
//        .bind(onNext: { [weak self] selectedItems in
//            let vc = GenreViewController()
//            vc.genre = self?.viewModel.didSelectGenre(itemAt: selectedItems)
//            self?.navigationController?.pushViewController(vc, animated: true)
//
//        }).disposed(by: disposeBag)
    }
}

extension GenreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  16
        let collectionViewSize = collectionView.frame.size.width - padding
        let collectionViewSizeH = collectionView.frame.size.height
        return CGSize(width: collectionViewSize/2, height: collectionViewSizeH/2)
    }
}

