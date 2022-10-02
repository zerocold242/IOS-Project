//
//  RootCoordinator.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 02.10.2022.
//

import UIKit

class RootCoordinator: RootCoordinatorProtocol {
    
    var childs: [RootCoordinatorProtocol] = []
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }
    
    func startTabBar() {
        let tabBarController = self.createTabBarController()
        self.window?.rootViewController = tabBarController
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let firstItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc.richtext"), tag: 0)
        let secondItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
        
        
        let firstCoordinator = FeedCoordinator()
        firstCoordinator.rootCoordinator = self
        firstCoordinator.startFeedViewController()
        let firstViewController = firstCoordinator.navigationController
        firstViewController.tabBarItem = firstItem
        
        let secondCoordinator = LoginCoordinator()
        secondCoordinator.rootCoordinator = self
        secondCoordinator.startLoginViewController()
        let secondViewControllerVC = secondCoordinator.navigationController
        secondViewControllerVC.tabBarItem = secondItem
        
        UITabBar.appearance().backgroundColor = .systemGray5
        tabBarController.viewControllers = [firstViewController,secondViewControllerVC]
        
        return tabBarController
    }
}



