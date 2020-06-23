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
    let persistenceManager: PersistenceManager
    
    private lazy var cameraBtn: CircleButton = {
        let button = CircleButton(frame: view.frame)
        button.layer.cornerRadius = view.bounds.width / 3
        button.addTarget(self, action: #selector(handleCameraBtn(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var albumBtn: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.stack")?.withTintColor(#colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleAlbumBarBtn(_:)))
        return barButton
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "터치하여 일상기록"
        label.textColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 27)
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
    init(persistenceManager: PersistenceManager) {
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotification()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetAnimation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - UI
    private func configureUI() {
        // Gradient
        let gradient = CAGradientLayer()
        let upperColor: CGColor = #colorLiteral(red: 0.6509803922, green: 0.6941176471, blue: 0.8823529412, alpha: 1)
        let lowerColor: CGColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
        gradient.colors = [upperColor, lowerColor]
        gradient.locations = [0 ,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        // NavigationController Settings
        navigationItem.title = "Capture the Moment"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)]
        navigationItem.rightBarButtonItems = [albumBtn]
        
        // AutoLayout
        welcomeLabelBottomAnchorConstant = welcomeLabel.bottomAnchor.constraint(equalTo: cameraBtn.topAnchor, constant: -20)
        
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
    
    func configureAnimation() {
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
    
    func resetAnimation() {
        welcomeLabelBottomAnchorConstant.constant = -20
        welcomeLabel.alpha = 0
        cameraBtn.transform = CGAffineTransform(scaleX: 1.00, y: 1.00)
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidEnterBackgroundNotification), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleWillEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    
    
    // MARK: - Selectors
    @objc private func handleCameraBtn(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        present(imagePicker, animated: true)
    }
    
    @objc private func handleAlbumBarBtn(_ sender: UIBarButtonItem) {
        let nextVC = UINavigationController(rootViewController: AlbumCollectionController())
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .coverVertical
        present(nextVC, animated: true)
    }
    
//    @objc private func handleAlbumBarBtn(_ sender: UIBarButtonItem) {
//        navigationController?.pushViewController(AlbumCollectionController(), animated: true)
//    }

    @objc func handleDidEnterBackgroundNotification() {
        resetAnimation()
    }
    
    @objc func handleWillEnterForegroundNotification() {
        configureAnimation()
    }
}


// MARK: - UIImagePickerControllerDelegate
extension HomeController: UIImagePickerControllerDelegate {
    
}


// MARK: - UINavigationControllerDelegate
extension HomeController: UINavigationControllerDelegate {
    
}
