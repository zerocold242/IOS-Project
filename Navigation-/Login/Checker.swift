//
//  Checker.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 12.09.2022.
//

import Foundation

class Checker {
    // 3 INT: Singleton
    static let shared = Checker()
    
    private let loginChecker: String
    private let passwordChecker: String
    
    private init() {
        self.loginChecker = "Aleksey"
        self.passwordChecker = "12345"
    }
    // 3 INT: верификация логина и пароля
    func check(passwordInput: String, loginInput: String) -> Bool {
        guard loginInput == self.loginChecker &&
                passwordInput == self.passwordChecker
        else {return false}
        return true
        
        
    }
}

