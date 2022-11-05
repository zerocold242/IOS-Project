//
//  LoginViewControllerDelegate.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 12.09.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    
    func isCheckDelegate(loginDelegate: String, passwordDelegate: String) -> Bool 

}
