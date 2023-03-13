//
//  CurrentUserService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 03.09.2022.
//

import Foundation
import UIKit

final class CurrentUserService: UserService {
    
    static let shared = CurrentUserService()
    
    var user = User(password: "5678",
                    login: "Aleksey",
                    fullName: "Zero Cold",
                    avatar: UIImage(named: "IMG_1566")!,
                    userStaus: "make techno!")
    
    func getUser(password: String, login: String) -> User? {
        if password == user.password,
           login == user.login {
            return user
        } else {
            print("не правильный логин или пароль")
            return nil
        }
    }
}
