//
//  User.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 03.09.2022.
//

import Foundation
import UIKit
import RealmSwift

//class LoginRealmModel: Object {
//
//    @Persisted(primaryKey: true) var userID = 0
//    @Persisted var password: String
//    @Persisted var login: String
//
//    convenience init(password: String, login: String) {
//        self.init()
//        self.password = password
//        self.login = login
//        self.userID = userID
//    }
//}

public final class RealmLoginModel: Object {
    @Persisted(primaryKey: true) var userID = 0
    @Persisted var password: String
    @Persisted var login: String
    
    convenience init(password: String, login: String) {
        self.init()
        self.password = password
        self.login = login
        self.userID = userID
    }
}

public final class User {
    
    public var fullName: String?
    public var avatar: UIImage
    public var userStatus: String?
    
    init (fullName: String?, avatar: UIImage, userStaus: String?) {
        
        self.fullName = fullName
        self.avatar = avatar
        self.userStatus = userStaus
    }
}
