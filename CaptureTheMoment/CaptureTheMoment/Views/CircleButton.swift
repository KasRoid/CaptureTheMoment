//
//  CircleButton.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/21/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    
    // MARK: - Properties
    let btnIcon = UIImage(systemName: "camera.fill")!
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    private func configureUI() {
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        imageView?.image = btnIcon
        imageView?.contentMode = .scaleAspectFill
        setImage(btnIcon, for: .normal)
        
        addSubview(imageView!)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        [
            imageView?.widthAnchor.constraint(equalToConstant: frame.width / 3.5),
            imageView?.heightAnchor.constraint(equalToConstant: frame.width / 3.5),
            ].forEach { $0?.isActive = true }
    }
}
