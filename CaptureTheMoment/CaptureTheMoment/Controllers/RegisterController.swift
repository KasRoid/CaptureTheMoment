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
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBackground
        image.layer.cornerRadius = view.bounds.width / 13
        image.contentMode = .scaleAspectFit
        return image
    }()
    var imageFromPicker: UIImage = UIImage()
    #if true
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelAction(_:)))
        return button
    }()
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveAction(_:)))
        return button
    }()
    #else
    lazy var cancelButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("취소", for: .normal)
         button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
         button.setTitleColor(.systemBlue, for: .normal)
         button.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
         return button
     }()
     lazy var saveButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("저장", for: .normal)
         button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
         button.setTitleColor(.systemBlue, for: .normal)
         button.addTarget(self, action: #selector(saveAction(_:)), for: .touchUpInside)
         return button
     }()
    #endif
    
    lazy var contentTitleTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "멋진 제목을 지어주세요"
        tf.backgroundColor = .systemTeal
        tf.borderStyle = .none
        tf.bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        return tf
    }()
    
    lazy var contentTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.preferredFont(forTextStyle: .body)
        tv.text = "당신의 이야기를 적어주세요"
        tv.textColor = .lightGray
        tv.backgroundColor = UIColor.cyan
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return tv
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1")
        configureUI()
        setLayout()
    }
    
    func setLayout() {
        let spacing: CGFloat = 16
        let safeArea = view.safeAreaLayoutGuide
        
        #if true
        [imageView, contentTextView, contentTitleTextField].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        #else
        [cancelButton, saveButton, imageView, contentField].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        [ cancelButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
          cancelButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0)
            ].forEach({$0.isActive = true})
        
        [ saveButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
          saveButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0)
            ].forEach({$0.isActive = true})
        #endif
        
        [
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: spacing * 2),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width - spacing * 3.5),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 3 / 7),
            
            contentTitleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            contentTitleTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing * 2),
            contentTitleTextField.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0),
            contentTitleTextField.heightAnchor.constraint(equalToConstant: 30),
            
            contentTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            contentTextView.topAnchor.constraint(equalTo: contentTitleTextField.bottomAnchor, constant: spacing / 3),
            contentTextView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0),
            contentTextView.heightAnchor.constraint(equalToConstant: 200)
            ].forEach({$0.isActive = true})
    }
    
    
    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        // Gradient
        let gradient = CAGradientLayer()
        let upperColor: CGColor = #colorLiteral(red: 0.8518349528, green: 0.835316956, blue: 0.9923551679, alpha: 1)
        let lowerColor: CGColor = #colorLiteral(red: 0.443330735, green: 0.3350912333, blue: 1, alpha: 1)
        gradient.colors = [upperColor, lowerColor]
        gradient.locations = [0 ,0.85]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        
        imageView.image = imageFromPicker
        contentTitleTextField.delegate = self
        contentTextView.delegate = self
        view.addSubview(imageView)
        view.addSubview(contentTextView)
        view.addSubview(contentTitleTextField)
        #if true
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = "기록"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Memory"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5956794024, green: 0.2148896754, blue: 1, alpha: 1)]
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.5956794024, green: 0.2148896754, blue: 1, alpha: 1)
        #else
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        #endif
        
    }
    
    func setConstraints() {
        //cancel button
        
    }
    
    @objc func cancelAction(_ sender: UIButton) {
        #if true
        // pop
        navigationController?.popViewController(animated: true)
        #else
        // present
        let hc = presentingViewController
        hc?.dismiss(animated: true)
        #endif
    }
    
    @objc func saveAction(_ sender: UIButton) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension RegisterController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\n----------[ textFieldDidEndEditing ]----------\n")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("\n----------[ textFieldDidBeginEditing ]----------\n")
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("\n----------[ textFieldDidChangeSelection ]----------\n")
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("\n----------[ textFieldShouldClear ]----------\n")
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("\n----------[ textFieldShouldReturn ]----------\n")
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("\n----------[ textFieldShouldEndEditing ]----------\n")
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("\n----------[ textFieldShouldBeginEditing ]----------\n")
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("\n----------[ textFieldDidEndEditing ]----------\n")
    }
}
extension RegisterController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        print("\n----------[ DidEndEditing ]----------\n")
        guard contentTextView.text != "" else {
            contentTextView.text = "당신의 이야기를 적어주세요"
            return
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("\n----------[ DidBeginEditing ]----------\n")
        contentTextView.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("\n----------[ DidChange ]----------\n")
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        print("\n----------[ DidChangeSelection ]----------\n")
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print("\n----------[ ShouldEndEditing ]----------\n")
        
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("\n----------[ ShouldBeginEditing ]----------\n")
        
        return true
    }
}
