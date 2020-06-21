//
//  ViewController.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/20/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

final class HomeController: UIViewController {
    
    // MARK: - Properties
    private lazy var cameraBtn: CircleButton = {
        let button = CircleButton(frame: view.frame)
        button.layer.cornerRadius = view.bounds.width / 3
        button.addTarget(self, action: #selector(handleCameraBtn(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var albumBtn: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.stack")?.withTintColor(#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleAlbumBarBtn(_:)))
        return barButton
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "터치하여 일상기록"
        label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 30)
        label.alpha = 0
        return label
    }()
    
    private var welcomeLabelBottomAnchorConstant: NSLayoutConstraint!
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        return imagePicker
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        welcomeLabelBottomAnchorConstant.constant = -20
        welcomeLabel.alpha = 0
        cameraBtn.transform = CGAffineTransform(scaleX: 1.00, y: 1.00)
    }
    
    
    // MARK: - UI
    private func configureUI() {
        // Gradient
        let gradient = CAGradientLayer()
        let upperColor: CGColor = #colorLiteral(red: 0.767367435, green: 0.7234390481, blue: 1, alpha: 1)
        let lowerColor: CGColor = #colorLiteral(red: 0.5145841203, green: 0.403913625, blue: 1, alpha: 1)
        gradient.colors = [upperColor, lowerColor]
        gradient.locations = [0 ,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        navigationItem.rightBarButtonItems = [albumBtn]
        
        welcomeLabelBottomAnchorConstant = welcomeLabel.bottomAnchor.constraint(equalTo: cameraBtn.topAnchor, constant: -20)
        
        // AutoLayout
        [cameraBtn, welcomeLabel].forEach() {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false }
        [
            cameraBtn.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.5),
            cameraBtn.heightAnchor.constraint(equalToConstant: view.bounds.width / 1.5),
            cameraBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            cameraBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            welcomeLabelBottomAnchorConstant,
            ].forEach { $0.isActive = true }
    }
    
    private func configureAnimation() {
        UIView.animate( // label 등장 애니메이션
            withDuration: 1,
            animations: {
                self.welcomeLabelBottomAnchorConstant.constant = -50
                self.welcomeLabel.alpha = 1
                self.view.layoutIfNeeded()
        })
        
        UIView.animate( // cameraBtn 숨 쉬는 애니메이션
            withDuration: 1.0,
            delay: 0,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                self.cameraBtn.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
        },
            completion: nil
            
        )
    }
    
    
    // MARK: - Selectors
    @objc private func handleCameraBtn(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        present(imagePicker, animated: true)
    }
    
    @objc private func handleAlbumBarBtn(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(AlbumCollectionController(), animated: true)
    }
}


// MARK: - UIImagePickerControllerDelegate
extension HomeController: UIImagePickerControllerDelegate {
    
}


// MARK: - UINavigationControllerDelegate
extension HomeController: UINavigationControllerDelegate {
    
}
