//
//  LoginCoordinator.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 02.10.2022.
//


import UIKit

class LoginCoordinator: RootCoordinatorProtocol, LoginCoordinatorDelegate, BackLoginDelegate {
    
    let navigationController: UINavigationController
    
    var childs = [RootCoordinatorProtocol]()
    
    required init() {
        self.navigationController = .init()
    }
    
    func startLoginViewController() {
        let loginViewController: LoginViewController = LoginViewController(userService: UserService.self as! UserService)
        self.navigationController.isNavigationBarHidden = true
        loginViewController.coordinator = self
        loginViewController.delegate = LoginInspector()
        self.navigationController.viewControllers = [loginViewController]
    }
    
    func navigateToNextPage(userService: UserService) {
        
        let profileCoordinator = ProfileCoorinator(navigationController: navigationController)
        profileCoordinator.delegate = self
        childs.append(profileCoordinator)
        profileCoordinator.startProfile()
    }
    
    func navigatePrevious(newCoordinator: ProfileCoorinator) {
        navigationController.popToRootViewController(animated: true)
        childs.removeLast()
    }
}
