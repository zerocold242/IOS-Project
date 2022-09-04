//
//  User.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 03.09.2022.
//

import Foundation
import UIKit

public final class User {
    public var login: String
    public var fullName: String
    public var avatar: UIImage
    public var userStatus: String
    
    init (login: String, fullName: String, avatar: UIImage, userStaus: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.userStatus = userStaus
    }
}
