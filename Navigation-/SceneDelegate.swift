//
//  SceneDelegate.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        
        let feedVC = FeedViewController()
        
        
#if DEBUG
        let logInVC = LoginViewController(userService: TestUserService())
#else
        let logInVC = LoginViewController(userService: CurrentUserService())
#endif
        logInVC.title = "Profile"
//INT 4.1: внедрение зависимосьти от LoginInspector
        logInVC.delegate = LoginInspector()
        
        let feedNavigationVC = UINavigationController(rootViewController: feedVC)
        feedNavigationVC.tabBarItem = UITabBarItem(title: "Feed",
                                                   image: UIImage(systemName: "doc.richtext"),
                                                   tag: 0)
        
        let logInNavigationVC = UINavigationController(rootViewController: logInVC)
        logInNavigationVC.isNavigationBarHidden = true
        logInNavigationVC.tabBarItem = UITabBarItem(title: "Profile",
                                                    image: UIImage(systemName: "person.circle"),
                                                    tag: 1)
        
        tabBarController.viewControllers = [feedNavigationVC, logInNavigationVC]
        UITabBar.appearance().backgroundColor = .systemGray5
        
        let photosViewController = PhotosViewController()
        photosViewController.title = "Photo Gallery"
        
        self.window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}


