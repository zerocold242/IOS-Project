//
//  ProfileHeaderview.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 31.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = ""
    
    private lazy var avatarImageView: UIImageView  = {
        
        let foto = UIImageView()
        
        foto.translatesAutoresizingMaskIntoConstraints = false
        foto.clipsToBounds = true
        foto.image = UIImage(named: "IMG_1566")
        foto.layer.cornerRadius = 50
        foto.layer.borderWidth = 3
        foto.layer.borderColor = UIColor.white.cgColor
        
        return foto
        
    }()
    
    private lazy var fullNameLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Zero Cold"
        
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray6
        label.text = "Waiting for something..."
        
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        
        let statusTextField = UITextField()
        
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.layer.cornerRadius = 12
        statusTextField.clipsToBounds = true
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.backgroundColor = .white
        
        statusTextField.delegate = self
        
        statusTextField.placeholder = "Enter your status..."
        
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.textAlignment = .center
        
        statusTextField.autocorrectionType = UITextAutocorrectionType.no
        statusTextField.keyboardType = UIKeyboardType.default
        statusTextField.returnKeyType = UIReturnKeyType.done
        statusTextField.clearButtonMode = UITextField.ViewMode.always
        statusTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        statusTextField.isEnabled = true
        statusTextField.isUserInteractionEnabled = true
        
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return statusTextField
    }()
    
    private lazy var setStatusButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.setTitleColor(.lightGray, for: .highlighted)
        button.setTitle("Show status", for: .normal)
        button.addTarget(self, action:  #selector(buttonPressed), for: .touchUpInside)
        
        return button
    }()
}

extension ProfileHeaderView {
    
    func configureView() {
        
        self.backgroundColor = .systemGray
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 28),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc func statusTextChanged(_ textField: UITextField) -> String {
        
        if let newStatus = textField.text {
            statusText = newStatus
        }
        return statusText
    }
    
    @objc func buttonPressed(sender: UIButton!) {
        
        print(statusTextField.text ?? "")
        guard statusTextField.text?.isEmpty == false else {return}
        statusLabel.text = statusTextChanged(statusTextField)
        self.statusTextField.text = ""
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        self.endEditing(true)
        
        return true
    }
}


