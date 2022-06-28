//
//  PostViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "Post"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGreen
        self.navigationItem.title = titlePost
        setupRightBarButton()
    }
    
    func setupRightBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Info",
                                             style: .plain,
                                             target: self, action: #selector(barButtonAction))
        self.navigationItem.rightBarButtonItem  = rightBarButton
    }
    
    @objc private func barButtonAction() {
        
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }
}

