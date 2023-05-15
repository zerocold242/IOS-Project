//
//  SceneDelegate.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//

import UIKit
//import FirebaseCore
//import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        
        let feedVC = FeedViewController()
        
        //iosDT-1.1
        // let appConfiguration = AppConfiguration.allCases.randomElement()!
        // if let url = URL(string: appConfiguration.rawValue) {
        //     NetworkService.urlParser(url)
        // }
        
#if DEBUG
        let logInVC = LoginViewController(/*userService: TestUserService()*/)
#else
        let logInVC = LoginViewController(/*userService: CurrentUserService()*/)
#endif
        logInVC.title = "Profile"
        //INT 4.1: внедрение зависимосьти от LoginInspector
        logInVC.delegate = LoginInspector()
        
        //INT 4.2 фабричный метод создания LoginInspector
        //logInVC.delegate = MyLoginFactory().createLoginInspector()
        
        let feedNavigationVC = UINavigationController(rootViewController: feedVC)
        feedNavigationVC.tabBarItem = UITabBarItem(title: "Feed",
                                                   image: UIImage(systemName: "doc.richtext"),
                                                   tag: 0)
        
        let logInNavigationVC = UINavigationController(rootViewController: logInVC)
        logInNavigationVC.isNavigationBarHidden = true
        logInNavigationVC.tabBarItem = UITabBarItem(title: "Profile",
                                                    image: UIImage(systemName: "person.circle"),
                                                    tag: 1)
        
        let postVC = LikedPostsController() //PostViewController()
        let postNavigationVC = UINavigationController(rootViewController: postVC)
        postNavigationVC.isNavigationBarHidden = false
        postNavigationVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "suit.heart"), tag: 2)
        
        let mapVC = MapViewController()
        let mapNavigationVC = UINavigationController(rootViewController: mapVC)
        mapNavigationVC.isNavigationBarHidden = false
        mapNavigationVC.tabBarItem = UITabBarItem(title: "Maps", image: UIImage(systemName: "location.circle"), tag: 3)
        
        
        tabBarController.viewControllers = [feedNavigationVC, logInNavigationVC, postNavigationVC, mapNavigationVC]
        UITabBar.appearance().backgroundColor = .systemGray5
        
        let photosViewController = PhotosViewController()
        photosViewController.title = "Photo Gallery"
        
        self.window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}


