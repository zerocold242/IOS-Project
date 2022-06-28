//
//  FeedViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    let stackView: UIStackView
    
    init (){
        stackView = UIStackView().self
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSteckView() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .fill
        
        let firstButton = UIButton()
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.backgroundColor = .systemBlue
        firstButton.layer.cornerRadius = 10
        firstButton.layer.shadowColor = UIColor.black.cgColor
        firstButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        firstButton.layer.shadowOpacity = 1
        firstButton.layer.shadowRadius = 5
        firstButton.setTitle("Go to the PostViewController", for: .normal)
        firstButton.setTitleColor(.lightGray, for: .highlighted)
        firstButton.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        stackView.addArrangedSubview(firstButton)
        
        let secondButton = UIButton()
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.backgroundColor = .blue
        secondButton.layer.cornerRadius = 10
        secondButton.layer.shadowColor = UIColor.black.cgColor
        secondButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        secondButton.layer.shadowOpacity = 1
        secondButton.layer.shadowRadius = 5
        secondButton.setTitle("Go to the PostViewController", for: .normal)
        secondButton.setTitleColor(.lightGray, for: .highlighted)
        secondButton.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        stackView.addArrangedSubview(secondButton)
        
        [stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10),
         stackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 5)]
            .forEach({$0.isActive = true})
    }
    
    @objc func showPost(){
        let postVc = PostViewController()
        navigationController?.pushViewController(postVc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        view.addSubview(stackView)
        setUpSteckView()
    }
}
