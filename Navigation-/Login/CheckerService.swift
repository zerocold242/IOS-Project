//
//  CheckerService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 30.10.2022.
//

import Foundation
import FirebaseAuth
import UIKit

protocol CheckerServiceProtocol {
    
    func checkCredentials( withEmail: String, password: String)
    func signUp(withEmail: String, password: String)
}

class CheckerService: CheckerServiceProtocol {
    
    static let shared = CheckerService()
    var isSignIn: Bool = false
    
    func checkCredentials(withEmail: String, password: String) {
        Auth.auth().signIn( withEmail: withEmail, password: password ) { [self]  authResult, error in
            if let error = error {
                print(error.localizedDescription)
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.userNotFound.rawValue:
                    let alert = UIAlertController(title: "Такой пользователь не найден", message: "Введите верно пароль и email или зарегистрируйтесь", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: {_ in print("Аккаунт не создан")}))
                    alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { [self]_ in
                        signUp (withEmail: withEmail, password: password)
                    CurrentUserService.shared.user.password = password
                    CurrentUserService.shared.user.login = withEmail
                                                  }))
                default:
                    let alert  = UIAlertController(title: "Что-то пошло не так", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    print(error)
                }
            } else {
                self.isSignIn = true
            }
        }
    }
    
    func signUp( withEmail: String, password: String) {
        Auth.auth().createUser(withEmail: withEmail, password: password) {authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                let alert  = UIAlertController(title: "Что-то пошло не так", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            } else {
                let alert  = UIAlertController(title: "Готово", message: "Регистрация прошла успешно", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                print("CheckerService/signUp")
            }
        }
    }
}




