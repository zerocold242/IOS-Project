//
//  LoginInspector.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 13.09.2022.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    func isCheckDelegate(loginDelegate: String, passwordDelegate: String) -> Bool {
        print("LoginInspector")
        return Checker.shared.check(passwordInput: passwordDelegate, loginInput: loginDelegate)
    }
}
