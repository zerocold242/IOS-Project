//
//  MyLoginFactory.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 17.09.2022.
//

import Foundation

class MyLoginFactory: LoginFactoryProtocol {
    
    func createLoginInspector() -> LoginInspector {
        let loginInspector = LoginInspector()
        print("createLoginInspector")
        return loginInspector
    }
}
