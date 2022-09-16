//
//  LoginFactory.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 16.09.2022.
//

import Foundation


protocol LoginFactoryProtocol {
    
    func createLoginInspector () -> LoginInspector
}

class MyLoginFactory: LoginFactoryProtocol {
    
    func createLoginInspector() -> LoginInspector {
        let loginInspector = LoginInspector()
        print("createLoginInspector")
        return loginInspector
    }
}
