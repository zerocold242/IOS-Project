//
//  TestUserService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 04.09.2022.
//

import Foundation
import UIKit

final class TestUserService: UserService {
    
    var testingUser = User(password: "123",
                           login: "testLogin",
                           fullName: "Test Mode",
                           avatar: UIImage(named: "f15")!,
                           userStaus: "testMode")
    
   func getUser(password: String, login: String) -> User? {
        guard password == testingUser.password else {return nil}
        guard login == testingUser.login else { return nil}
            return testingUser
        }
    }
