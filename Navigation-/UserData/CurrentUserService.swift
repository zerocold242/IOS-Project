//
//  CurrentUserService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 03.09.2022.
//

import Foundation
import UIKit

final class CurrentUserservice: UserService {
    
     var user = User(login: "Aleksey",
                            fullName: "Zero Cold",
                     avatar: UIImage(named: "IMG_1566") ?? UIImage.add,
                            userStaus: "make techno!")
    
    func getLogin(login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
}
