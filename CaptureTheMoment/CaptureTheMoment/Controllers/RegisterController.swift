//
//  RegisterController.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/20/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

final class RegisterController: UIViewController {
    
    // MARK: - Properties
    let persistenceManager: PersistenceManager
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBackground
        image.layer.cornerRadius = view.bounds.width / 13
        image.contentMode = .scaleAspectFit
        return image
    }()
    var imageFromPicker: UIImage = UIImage()
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelAction(_:)))
        return button
    }()
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveAction(_:)))
        return button
    }()
        
    lazy var contentTitleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "멋진 제목을 지어주세요"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var contentTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.preferredFont(forTextStyle: .body)
        tv.text = "당신의 이야기를 적어주세요"
        tv.textColor = .lightGray
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 5
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return tv
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
        setUI()
        setLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contentTitleTextField.becomeFirstResponder()
    }
    
    // MARK: - UI
    
    func setLayout() {
        let spacing: CGFloat = 16
        let safeArea = view.safeAreaLayoutGuide
        
        [imageView, contentTextView, contentTitleTextField].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        [imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: spacing * 2),
         imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
                        contentTitleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: spacing * 2),
            contentTitleTextField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            contentTitleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            contentTitleTextField.heightAnchor.constraint(equalToConstant: 40),
            contentTextView.topAnchor.constraint(equalTo: contentTitleTextField.bottomAnchor, constant: spacing / 3),
            contentTextView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            contentTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            contentTextView.heightAnchor.constraint(equalToConstant: 200)].forEach({$0.isActive = true})
    }
    
    private func setUI() {
        
        // view
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        // Gradient
        let gradient = CAGradientLayer()
        let upperColor: CGColor = colorPalette.upperGradientColor.cgColor
        let lowerColor: CGColor = colorPalette.lowerGradientColor.cgColor
        gradient.colors = [upperColor, lowerColor]
        gradient.locations = [0 ,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        // imageView
        imageView.image = imageFromPicker
        view.addSubview(imageView)
        
        // contentTextView
        contentTextView.delegate = self
        view.addSubview(contentTextView)
        
        // contentTitleTextField
        contentTitleTextField.addLeftPadding()
        contentTitleTextField.delegate = self
        view.addSubview(contentTitleTextField)
        
        // navigation
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = "기록"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Memory"
        navigationController?.navigationBar.tintColor = colorPalette.upperGradientColor
    }
    
    
    // MARK: - Selectors
    
    @objc func cancelAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveAction(_ sender: UIButton) {
        persistenceManager.saveData(imageView: imageView, textView: contentTextView)
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


// MARK: - UITextFieldDelegate
extension RegisterController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    }
}

// MARK: - UITextViewDelegate
extension RegisterController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        guard contentTextView.text != "" else {
            contentTextView.text = "당신의 이야기를 적어주세요"
            return
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        contentTextView.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
}

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
