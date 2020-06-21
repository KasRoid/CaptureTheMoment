//
//  ViewController.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/20/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Properties
    lazy var cameraBtn: CircleButton = {
        let button = CircleButton(frame: view.frame)
        button.layer.cornerRadius = view.bounds.width / 3
        button.addTarget(self, action: #selector(handleCameraBtn(_:)), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - UI
    private func configureUI() {
        let gradient = CAGradientLayer()
        let upperColor: CGColor = #colorLiteral(red: 0.767367435, green: 0.7234390481, blue: 1, alpha: 1)
        let lowerColor: CGColor = #colorLiteral(red: 0.5145841203, green: 0.403913625, blue: 1, alpha: 1)
        gradient.colors = [upperColor, lowerColor]
        gradient.locations = [0 ,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        [cameraBtn].forEach() {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false }
        [
            cameraBtn.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.5),
            cameraBtn.heightAnchor.constraint(equalToConstant: view.bounds.width / 1.5),
            cameraBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            cameraBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            ].forEach { $0.isActive = true }
    }
    
    
    // MARK: - Selectors
    @objc private func handleCameraBtn(_ sender: UIButton) {
        print("Button Clicked")
    }
}

