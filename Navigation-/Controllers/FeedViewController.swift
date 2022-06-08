//
//  FeedViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var button: UIButton = {
        
        let button = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - 100,
                                            y: self.view.bounds.height / 2 - 25,
                                            width: 200,
                                            height: 50))
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.setTitle("Go to the Post", for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    } ()
    
    var post: Post = .init(title: "My first Post")
    
    private func setButton() {
        
        self.view.addSubview(self.button)
    }
    
    @objc private func buttonAction() {
        
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
        postViewController.titlePost = post.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        setButton()
    }
}
