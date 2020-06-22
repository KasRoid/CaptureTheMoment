//
//  DetailViewController.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/20/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    // MARK: - Properties
    private lazy var imageViewer: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = view.bounds.width / 13
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var commentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Comment"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 이런식으로 사용자가 작성한 코멘트가 불러와 보여집니다"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var editBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "exclamationmark.square"), style: .plain, target: self, action: #selector(handleEditBtn(_:)))
        return button
    }()
    
    private lazy var returnBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.down"), style: .plain, target: self, action: #selector(handleReturnBtn(_:)))
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .black
        view.alpha = 0.9
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.5956794024, green: 0.2148896754, blue: 1, alpha: 1)
        
        navigationItem.leftBarButtonItems = [returnBtn]
        navigationItem.rightBarButtonItems = [editBtn]
        
        [imageViewer, commentTitleLabel, commentLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let spacing: CGFloat = 16
        [
            imageViewer.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageViewer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing),
            imageViewer.widthAnchor.constraint(equalToConstant: view.bounds.width - spacing * 2),
            imageViewer.heightAnchor.constraint(equalToConstant: view.bounds.height * 3 / 5),
            
            commentTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            commentTitleLabel.topAnchor.constraint(equalTo: imageViewer.bottomAnchor, constant: spacing * 2),
            commentTitleLabel.leadingAnchor.constraint(equalTo: imageViewer.leadingAnchor, constant: 0),
            commentTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            commentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            commentLabel.topAnchor.constraint(equalTo: commentTitleLabel.bottomAnchor, constant: spacing / 3),
            commentLabel.leadingAnchor.constraint(equalTo: imageViewer.leadingAnchor, constant: 0),
            commentLabel.heightAnchor.constraint(equalToConstant: 30),
            ].forEach { $0.isActive = true }
    }
    
    // MARK: - Selectors
    @objc private func handleEditBtn(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func handleReturnBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
