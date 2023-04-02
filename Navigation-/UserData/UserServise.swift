//
//  UserServise.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 03.09.2022.
//

import Foundation

protocol UserService {
    
    func createUser(user: User) -> User?
    func readUser() -> User?
    
    
    //func getUser(password: String, login: String) -> User?
}
