//
//  CustomButton.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 18.09.2022.
//

import UIKit

class CustomButton: UIButton {
 
// INT 6.1: замыкание принимающее действие для func buttonTaped
     var actionTap: (() -> Void)?
    
// INT 6.1: инициализатор с основными параметрами кнопки
    init (title: String, titleColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .highlighted)
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(buttonTaped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// INT 6.1: функция передающая вызывающая действия из замыкания
    @objc private func buttonTaped(_: UIButton) {
        actionTap?()
        print("buttonTaped")
    }
}
