//
//  LoginViewControllerDelegate.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 12.09.2022.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    

    //func isCheckDelegate(loginDelegate: String, passwordDelegate: String) -> Bool
    
    func signUpdelegate(loginDelegate: String, passwordDelegate: String)


}

