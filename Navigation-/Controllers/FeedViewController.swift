//
//  FeedViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let stackView: UIStackView
    
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

        //INT 6.2: поле ввода секретного слова
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.backgroundColor = .white
        textfield.placeholder = "   Secret word"
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 10
        textfield.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.black.cgColor
        stackView.addArrangedSubview(textfield)
        
        //INT 6.2: лэйбл индикатор проверки
        let label = UILabel()
        label.backgroundColor = .gray
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        stackView.addArrangedSubview(label)
        
        //INT 6.2INT
        let checkPass = CustomButton(title: "Check Secret word", titleColor: .lightGray)
        checkPass.layer.shadowColor = UIColor.black.cgColor
        checkPass.layer.shadowOffset = CGSize(width: 2, height: 2)
        checkPass.layer.shadowOpacity = 1
        checkPass.layer.shadowRadius = 5
        //checkPass.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        stackView.addArrangedSubview(checkPass)
    
        [stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10),
         stackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2)]
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
