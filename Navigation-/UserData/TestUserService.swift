//
//  TestUserService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 04.09.2022.
//

import Foundation
import UIKit

final class TestUserService: UserService {
    
    var testingUser = User(/*password: "1234",
                            login: "testLogin",*/
        fullName: "Test Mode",
        avatar: UIImage(named: "f15")!,
        userStaus: "testMode")
    
    func createUser(user: User) -> User? {
        self.testingUser
    }
    
    func readUser() -> User? {
        self.testingUser
    }
    
    // func getUser(password: String, login: String) -> User? {
    //
    //     if password == testingUser.password,
    //        login == testingUser.login {
    //         return testingUser
    //     } else {
    //         return nil
    //     }
    // }
}

