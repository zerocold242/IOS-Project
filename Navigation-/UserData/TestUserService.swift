//
//  TestUserService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 04.09.2022.
//

import Foundation
import UIKit

final class TestUserService: UserService {
    
    var testingUser = User(login: "testLogin", fullName: "Test Mode", avatar: UIImage(named: "f16") ?? UIImage.add, userStaus: "testMode")
    
    func getLogin(login: String) -> User? {
        
        if login == testingUser.login {
            return testingUser
        } else {
            return nil
        }
    }
}
