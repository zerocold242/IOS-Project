//
//  InfoViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//

import UIKit

class InfoViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemTeal
            setupButton()
        }
    
       private func setupButton() {
            
            let alertButton = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - 100,
                                                     y: self.view.bounds.height / 2 - 25,
                                                     width: 200,
                                                     height: 50))
            alertButton.setTitle("Alert", for: .normal)
            alertButton.setTitleColor(.lightGray, for: .highlighted)
            alertButton.backgroundColor = .blue
            alertButton.layer.cornerRadius = 12
            alertButton.addTarget(self, action: #selector(setupAlert), for: .touchUpInside)
            alertButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            self.view.addSubview(alertButton)
        }
        
        @objc func setupAlert() {
            
            let title = "Warning!"
            let message = "Была нажата кнопка Alert в InfoViewController"
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in
                print("Нажата кнопка Cancel")
            }
            
            let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in
                print("Нажата кнопка Ок")
            }
            
            alert.addAction(actionCancel)
            alert.addAction(actionOk)
            self.present(alert, animated: true, completion: nil)
        }
    }
