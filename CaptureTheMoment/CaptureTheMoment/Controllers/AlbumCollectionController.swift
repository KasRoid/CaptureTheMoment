//
//  AlbumCollectionController.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/20/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

final class AlbumCollectionController: UIViewController {

    // MARK: - Properties
    let cellItem = colorItems()
    
    lazy private var collectionView = { () -> UICollectionView in
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.flowLayout)
        collectionView.register(AlbumCollectionCell.self, forCellWithReuseIdentifier: AlbumCollectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy private var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        let numberOfItemsInEachLine: CGFloat = 3
        let spaceBetweenEachItem: CGFloat = 8
        let edge: CGFloat = 8
        
        let spaceNeededInHorizontalLine = ((spaceBetweenEachItem * (numberOfItemsInEachLine - 1) + edge * 2)) / 2
        let width = (view.bounds.width / numberOfItemsInEachLine - spaceBetweenEachItem) * 0.97
        let height = width * 1.3
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = spaceBetweenEachItem
        layout.minimumInteritemSpacing = spaceBetweenEachItem
        layout.sectionInset = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge)
        return layout
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = #colorLiteral(red: 0.8518349528, green: 0.835316956, blue: 0.9923551679, alpha: 1)
        
        navigationItem.title = "Album"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5956794024, green: 0.2148896754, blue: 1, alpha: 1)]
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.5956794024, green: 0.2148896754, blue: 1, alpha: 1)
        
        view.addSubview(collectionView)
    }
}


// MARK: - UICollectionViewDataSource
extension AlbumCollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellItem.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionCell.identifier, for: indexPath)
        cell.backgroundColor = cellItem.items[indexPath.item].color
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension AlbumCollectionController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailVC = DetailViewController()
        let naviDetailVC = UINavigationController(rootViewController: DetailVC)
        naviDetailVC.modalPresentationStyle = .overFullScreen
        present(naviDetailVC, animated: true, completion: nil)
    }
}
