//
//  FeedViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var feedModel = FeedModel()
    
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
        stackView.addArrangedSubview(checkGuessButton)
        stackView.addArrangedSubview(checkLabel)
        stackView.addArrangedSubview(textfield)
        
        let firstButton = UIButton()
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.backgroundColor = .systemBlue
        firstButton.layer.cornerRadius = 10
        firstButton.layer.shadowColor = UIColor.black.cgColor
        firstButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        firstButton.layer.shadowOpacity = 1
        firstButton.layer.shadowRadius = 5
        firstButton.setTitle(~LocalizedKeys.firstButton.rawValue, for: .normal)
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
        secondButton.setTitle(~LocalizedKeys.secondButton.rawValue, for: .normal)
        secondButton.setTitleColor(.lightGray, for: .highlighted)
        secondButton.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        stackView.addArrangedSubview(secondButton)
        
        [stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10),
         stackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2)]
            .forEach({$0.isActive = true})
    }
    
    //INT 6.2: поле ввода секретного слова
    let textfield: UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.backgroundColor = .white
        textfield.placeholder = ~LocalizedKeys.secretTextField.rawValue
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 10
        textfield.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()
    
    //INT 6.2: кнопка проверки
    let checkGuessButton: CustomButton = {
        let checkGuessButton = CustomButton(title: ~LocalizedKeys.checkButton.rawValue, titleColor: .lightGray)
        checkGuessButton.layer.shadowColor = UIColor.black.cgColor
        checkGuessButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        checkGuessButton.layer.shadowOpacity = 1
        checkGuessButton.layer.shadowRadius = 5
        return checkGuessButton
    }()
    
    //INT 6.2: лэйбл индикатор проверки
    let checkLabel: UILabel = {
        let checkLabel = UILabel()
        checkLabel.backgroundColor = .gray
        checkLabel.clipsToBounds = true
        checkLabel.layer.cornerRadius = 10
        checkLabel.layer.borderWidth = 1
        checkLabel.layer.borderColor = UIColor.black.cgColor
        return checkLabel
    }()
    
    func checkPasstext() {
        checkGuessButton.actionTap = { [self] in
            print("checkPasstext")
            guard let text = textfield.text else { return }
            guard feedModel.check(word: text) == true
            else { return checkLabel.backgroundColor = .red }
            checkLabel.backgroundColor = .green
        }
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
        checkPasstext()
    }
}
