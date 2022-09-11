//
//  UserServise.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 03.09.2022.
//

import Foundation

protocol UserService {
    
    func getUser(password: String, login: String) -> User?
}
