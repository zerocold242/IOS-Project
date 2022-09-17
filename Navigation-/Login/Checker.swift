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
    //private let currentUserSevice = CurrentUserService()
    //private let testUserService = TestUserService()
    
    private init() {
        
#if DEBUG
        self.loginChecker = "testLogin"//testUserService.testingUser.login!
        self.passwordChecker = "123" //testUserService.testingUser.password!
#else
        self.loginChecker = "Aleksey"//currentUserSevice.user.login!
        self.passwordChecker = "12345"//currentUserSevice.user.password!
#endif
        
    }
    
    // 3 INT: верификация логина и пароля
    func check(passwordInput: String, loginInput: String) -> Bool {
        guard loginInput == self.loginChecker else {return false}
        guard passwordInput == self.passwordChecker else {return false}
        print("Checker")
        return true
    }
}

