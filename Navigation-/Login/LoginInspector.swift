//
//  LoginInspector.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 13.09.2022.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    func isCheckDelegate(loginDelegate: String, passwordDelegate: String) -> Bool {
        return Checker.shared.check(passwordInput: loginDelegate, loginInput: passwordDelegate)
    }
}
