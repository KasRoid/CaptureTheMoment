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
        collectionView.register(
            AlbumCollectionCell.self,
            forCellWithReuseIdentifier:
            AlbumCollectionCell.identifier)
        collectionView.register(
            AlbumCollectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: AlbumCollectionHeader.identifier)
        collectionView.register(
            AlbumCollectionFooter.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: AlbumCollectionFooter.identifier)
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
        
        layout.headerReferenceSize = CGSize(width: 40, height: 40)
        layout.footerReferenceSize = CGSize(width: 1, height: 1)
        return layout
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6941176471, blue: 0.8823529412, alpha: 1)
        
        navigationItem.title = "Album"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1).withAlphaComponent(0.8)
        navigationController?.navigationBar.barStyle = .black
        
        
        view.addSubview(collectionView)
        
        // Status bar 세팅
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1).withAlphaComponent(0.8)
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.red
        }
    }
    
    func addBlurEffect() {
        var bounds = self.navigationController?.navigationBar.bounds ?? CGRect.zero
        bounds.size.height += 50
        bounds.origin.y -= 50
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        self.navigationController?.navigationBar.sendSubviewToBack(visualEffectView)
    }
    
    
    // MARK: - Selectors
    @objc private func handleBackBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}


// MARK: - UICollectionViewDataSource
extension AlbumCollectionController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: AlbumCollectionHeader.identifier,
                for: indexPath) as! AlbumCollectionHeader
            header.titleLabel.text = "Section"
            return header
        }
        else {
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: AlbumCollectionFooter.identifier,
                for: indexPath) as! AlbumCollectionFooter
            return footer
        }
    }
    
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
