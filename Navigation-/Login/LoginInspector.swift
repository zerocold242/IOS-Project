//
//  LoginInspector.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 13.09.2022.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    
    func signUpdelegate(loginDelegate: String, passwordDelegate: String) {
        CheckerService.shared.signUp(withEmail: loginDelegate, password: passwordDelegate)
        print("LoginInspector signUp")
    }
    
    func isCheckDelegate(loginDelegate: String, passwordDelegate: String) -> Bool {
        CheckerService.shared.checkCredentials(withEmail: loginDelegate, password: passwordDelegate)
        if CheckerService.shared.isSignIn == true {
            print("LoginInspector SignIn")
            return true
        } else {
            return false
        }
    }
}


