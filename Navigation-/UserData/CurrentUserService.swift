//
//  CurrentUserService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 03.09.2022.
//

import Foundation
import UIKit

final class CurrentUserservice: UserService {
    
    var user = User(password: "12345",
                    login: "Aleksey",
                    fullName: "Zero Cold",
                    avatar: UIImage(named: "IMG_1566")!,
                    userStaus: "make techno!")
    
    func getLogin(password: String, login: String) -> User? {
        if password == user.password, login == user.login {
            return user
        } else {
            return nil
        }
    }
}
