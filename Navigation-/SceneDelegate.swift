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
        
        //let feedViewController = FeedViewController()
        //let profileViewController = ProfileViewController()
        //let feedNavigationViewController = UINavigationController(rootViewController: feedViewController)
        //let profileNavigationViewController = UINavigationController(rootViewController: profileViewController)
        
        //let tabBarController = createTabBarController()
        //tabBarController.viewControllers = [createFeedViewController(), createProfileViewController()]
        
        let loginViewController = LoginViewController()
        let _ = UINavigationController(rootViewController: loginViewController)
        loginViewController.tabBarItem = UITabBarItem(title: "Profile",
                                                        image: UIImage(systemName: "person.circle"),
                                                       tag: 1)
        
        func createFeedViewController() -> UINavigationController {
            
            let feedViewController = FeedViewController()
            feedViewController.title = "Feed"
            feedViewController.tabBarItem = UITabBarItem(title: "Feed",
                                                         image: UIImage(systemName: "doc.richtext"),
                                                         tag: 0)
            return UINavigationController(rootViewController: feedViewController)
        }
        
        func createProfileViewController() -> UINavigationController {
            
            let profileViewController = ProfileViewController()
            profileViewController.title = "Profile"
            profileViewController.tabBarItem = UITabBarItem(title: "Profile",
                                                            image: UIImage(systemName: "person.circle"),
                                                            tag: 1)
            return UINavigationController(rootViewController: loginViewController)
        }
        
        func createTabBarController() -> UITabBarController {
            
            let tabBarController = UITabBarController()
            UITabBar.appearance().backgroundColor = .tertiarySystemBackground
            tabBarController.viewControllers = [createFeedViewController(), createProfileViewController()]
            return tabBarController
        }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }
}


