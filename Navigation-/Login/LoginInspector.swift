//
//  LoginInspector.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 13.09.2022.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    func isCheckDelegate(loginDelegate: String, passwordDelegate: String) -> Bool {
        //if CheckerService.shared.isSignIn == true {
        CheckerService.shared.checkCredentials(withEmail: loginDelegate, password: passwordDelegate)
            if CheckerService.shared.isSignIn == true {
            print("LoginInspector SignIn")
           // return true
            } else {
                CheckerService.shared.signUp(withEmail: loginDelegate, password: passwordDelegate)
                print("LoginInspector signUp")
               // return false
            //return Checker.shared.check(passwordInput: passwordDelegate, loginInput: loginDelegate)
            
            
        }
        return true
    }
    
}
