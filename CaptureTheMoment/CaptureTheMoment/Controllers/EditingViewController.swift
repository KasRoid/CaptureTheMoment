//
//  EditingViewController.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/24/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {
    
    lazy var cancelBtn: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelBtn(_:)))
        return barButton
    }()
    
    lazy var saveBtn: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveBtn(_:)))
        return barButton
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Comment"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.862745098, green: 0.8392156863, blue: 0.968627451, alpha: 1)
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Comment"
        textField.becomeFirstResponder()
        return textField
    }()
    
    lazy var deleteLineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var deleteBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이미지 삭제하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        button.addTarget(self, action: #selector(handleDeleteBtn(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
        navigationItem.title = "Edit"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.leftBarButtonItems = [cancelBtn]
        navigationItem.rightBarButtonItems = [saveBtn]
        
        // Gradient
        let gradient = CAGradientLayer()
        let upperColor: CGColor = #colorLiteral(red: 0.6509803922, green: 0.6941176471, blue: 0.8823529412, alpha: 1)
        let lowerColor: CGColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
        gradient.colors = [upperColor, lowerColor]
        gradient.locations = [0 ,0.70]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        [commentTextField, deleteBtn, deleteLineLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            commentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            commentTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70),
            
            deleteLineLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            deleteLineLabel.heightAnchor.constraint(equalToConstant: 40),
            deleteLineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            deleteLineLabel.topAnchor.constraint(equalTo: commentTextField.bottomAnchor, constant: 40),
            
            deleteBtn.centerXAnchor.constraint(equalTo: deleteLineLabel.centerXAnchor, constant: 0),
            deleteBtn.centerYAnchor.constraint(equalTo: deleteLineLabel.centerYAnchor, constant: 0),
        ])
        view.bringSubviewToFront(deleteBtn)
    }
    
    
    
    // MARK: - Selectors
    @objc private func handleCancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSaveBtn(_ sender: UIButton) {
        guard let navi = self.presentingViewController as? UINavigationController else { return }
        navi.viewControllers.forEach {
            guard let vc = $0 as? DetailViewController else { return }
            vc.commentLabel.text = self.commentTextField.text
        }
        dismiss(animated: true)
    }
    
    @objc private func handleDeleteBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "이미지 삭제", message: "이미지를 정말 삭제하시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "삭제", style: .destructive, handler: nil)
        [cancelAction, confirmAction].forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}
