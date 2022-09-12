//
//  Checker.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 12.09.2022.
//

import Foundation

class Checker {
    
    private let loginChecker: String
    private let passwordChecker: String
    
    private init() {
        self.loginChecker = "Aleksey"
        self.passwordChecker = "12345"
        
        func check(passwordInput: String, loginInput: String) -> Bool {
            guard loginInput == self.loginChecker &&
                    passwordInput == self.passwordChecker
            else {return false}
            return true
            
        }
    }
}

