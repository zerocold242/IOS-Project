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
    private let currentUserSevice = CurrentUserService()
    private let testUserService = TestUserService()
    
    private init() {
#if DEBUG
        self.loginChecker = testUserService.testingUser.login!
        self.passwordChecker = testUserService.testingUser.password!
#else
        self.loginChecker = currentUserSevice.user.login!
        self.passwordChecker = currentUserSevice.user.password!
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

