//
//  CurrentUserService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 03.09.2022.
//

import Foundation
import UIKit

final class CurrentUserService: UserService {
    
    var user = User(password: "12345",
                    login: "Aleksey",
                    fullName: "Zero Cold",
                    avatar: UIImage(named: "IMG_1566")!,
                    userStaus: "make techno!")
    
      func getUser(password: String, login: String) -> User? {
        guard password == user.password else {return nil}
        guard login == user.login else {return nil}
            return user
        }
    }
