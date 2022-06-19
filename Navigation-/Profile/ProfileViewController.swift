//
//  ProfileViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileHeaderView = ProfileHeaderView()
    
    private func setupProfileView() {
    
        self.view.addSubview(self.profileHeaderView)
        self.profileHeaderView.frame = self.view.frame
        self.profileHeaderView.configureView()
        profileHeaderView.layoutIfNeeded()
        view.layoutIfNeeded()
    }
    
    private func addButton() {
        let button: UIButton = {
            
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 4
            button.setTitleColor(.lightGray, for: .highlighted)
            button.setTitle("New Button", for: .normal)
            
            return button
        }()
        
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            //profileHeaderView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    // убираем клавиатуру кликом по вью:
    private func gesture() {
        
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(self.gestureAction))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc private func gestureAction() {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        setupProfileView()
        gesture()
        addButton()
    }
}







 
