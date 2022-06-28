//
//  ProfileHeaderview.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 31.05.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private lazy var statusText: String = ""
    
    private lazy var avatarImageView: UIImageView = {
        
        let image = UIImageView()
        image.layer.borderWidth = 3
        image.layer.cornerRadius = 110/2
        image.layer.borderColor = UIColor.white.cgColor
        image.image = UIImage(named: "IMG_1566")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var fullNameLabel: UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.text = "Zero Cold"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private lazy var statusLabel: UILabel = {
        
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.textColor = .gray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return statusLabel
    }()
    
    private lazy var statusTextField: UITextField = {
        
        let statusTextField = UITextField()
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.layer.cornerRadius = 12
        statusTextField.clipsToBounds = true
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.backgroundColor = .white
        statusTextField.placeholder = "Enter your status..."
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.textAlignment = .center
        statusTextField.autocorrectionType = UITextAutocorrectionType.no
        statusTextField.keyboardType = UIKeyboardType.default
        statusTextField.returnKeyType = UIReturnKeyType.done
        statusTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        statusTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        statusTextField.isEnabled = true
        statusTextField.isUserInteractionEnabled = true
        
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return statusTextField
    }()
    
    private lazy var setStatusButton: UIButton = {
        
        let statusButton = UIButton()
        statusButton.setTitle("Set status", for: .normal)
        statusButton.setTitleColor(.lightGray, for: .highlighted)
        statusButton.backgroundColor = .systemBlue
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return statusButton
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupProfileHeaderView()
    }
    
   // override func layoutSubviews() {
   //     super.layoutSubviews()
   //     avatarImageView.layer.cornerRadius = 110/2
   //     avatarImageView.clipsToBounds = true
   // }
    
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    private func setupProfileHeaderView() {
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        contentView.addSubview(setStatusButton)
        
        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 110),
            avatarImageView.heightAnchor.constraint(equalToConstant: 110),
            
            fullNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            fullNameLabel.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            
            setStatusButton.topAnchor .constraint(equalTo: avatarImageView.bottomAnchor, constant: 32),
            setStatusButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.topAnchor, constant: 34),
            statusLabel.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor),
            statusTextField.rightAnchor.constraint(equalTo: setStatusButton.rightAnchor)
        ])
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) -> String {
        
        if let newStatus = textField.text {
            statusText = newStatus
        }
        return statusText
    }
    
    @objc private func buttonPressed(sender: UIButton!) {
        
        print(statusTextField.text ?? "")
        guard statusTextField.text?.isEmpty == false else {
            statusLabel.text = "Waiting fo somthing..."
            
            return
        }
        
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


