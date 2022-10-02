//
//  LoginCoordinator.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 02.10.2022.
//


import UIKit

class LoginCoordinator: RootCoordinatorProtocol, LoginCoordinatorDelegate, BackLoginDelegate {
    
    weak var rootCoordinator: RootCoordinator?
    let navigationController: UINavigationController
    var childs = [RootCoordinatorProtocol]()
    
    required init() {
        self.navigationController = .init()
    }
   
    
    func startLoginViewController() {
#if DEBUG
        let userService = TestUserService()
#else
        let userService = CurrentUserService()
#endif
        let loginViewController: LoginViewController = LoginViewController(userService: userService)
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

