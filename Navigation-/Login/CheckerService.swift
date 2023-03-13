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
                    SharedAlert.shared.showAlert( alertTitle: "Пользователь с таким email не найден", alertMessage: "Проверьте правильность email или нажмите Sign Up для регистрации")
                case AuthErrorCode.invalidEmail.rawValue:
                     // Error: The email address is badly formatted.
                    SharedAlert.shared.showAlert( alertTitle: "Неверный формат email адреса", alertMessage: "Проверьте правильность ввода email адреса")
                case AuthErrorCode.wrongPassword.rawValue:
                    // Error: The password is invalid or the user does not have a password.
                    SharedAlert.shared.showAlert( alertTitle: "Неверный пароль", alertMessage: "Проверьте правильность ввода пароля")

                default:
                    
                    SharedAlert.shared.showAlert(alertTitle: "Что-то пошло не так", alertMessage: error.localizedDescription)
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
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                     // Error: The email address is already in use by another account.
                    SharedAlert.shared.showAlert( alertTitle: "Этот email адрес уже используется", alertMessage: "Используйте другой email адрес для регистрации или нажмите Log In для входа в аккаунт")
                case AuthErrorCode.invalidEmail.rawValue:
                     // Error: The email address is badly formatted.
                    SharedAlert.shared.showAlert( alertTitle: "Неверный формат email адреса", alertMessage: "Проверьте правильность написания email адреса")
                case AuthErrorCode.weakPassword.rawValue:
                     // Error: The password must be 6 characters long or more.
                    SharedAlert.shared.showAlert( alertTitle: "Пароль слишком короткий", alertMessage: "Пароль должен содержать не менее шести символов")
                   default:
                    SharedAlert.shared.showAlert( alertTitle: "Что-то пошло не так", alertMessage: error.localizedDescription)
                     
                       print("Error: \(error.localizedDescription)")
                   }
               // SharedAlert.shared.showAlert( alertTitle: "Что-то пошло не так", alertMessage: error.localizedDescription)
                
            } else {
                
                SharedAlert.shared.showAlert( alertTitle: "Готово", alertMessage: "Вы успешно зарегистрировались, нажмите Log In для входа в аккаунт")
                print("CheckerService/signUp")
            }
        }
    }
}




