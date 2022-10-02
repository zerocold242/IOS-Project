//
//  ProfileCoordinator.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 29.09.2022.
//

import Foundation
import UIKit

protocol BackLoginDelegate: AnyObject {
    func navigatePrevious( newCoordinator: RootCoordinatorProtocol)
}

class ProfileCoorinator: RootCoordinatorProtocol, ProfileVCDelegate {
    func navigateNextPage(){}
    
    
    var childs = [RootCoordinatorProtocol]()
    weak var delegate: BackLoginDelegate?
    unowned let navigationController: UINavigationController

    
    
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startProfile() {
        
#if DEBUG
        let logInVC = LoginViewController(userService: TestUserService())
        let userService = TestUserService()
        let user = logInVC.userService.getUser(password: userService.testingUser.password!, login: userService.testingUser.login!)
#else
        let logInVC = LoginViewController(userService: CurrentUserService())
        let userService = CurrentUserService()
        let user = logInVC.userService.getUser(password: userService.user.password!, login: userService.user.login!)
#endif
        logInVC.delegate = LoginInspector()
        let profileVC: ProfileViewController = ProfileViewController(currentUser: user!)
        profileVC.coordinator = self
        self.navigationController.pushViewController(profileVC, animated: true)
    }
    
    func navigatePrevious() {
        self.delegate?.navigatePrevious(newCoordinator: self)
    }
}
