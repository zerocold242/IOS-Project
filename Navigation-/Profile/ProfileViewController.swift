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
    
    override func viewWillLayoutSubviews() {
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
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
    }
}







 
