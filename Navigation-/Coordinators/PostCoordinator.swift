//
//  PostCoordinator.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 02.10.2022.
//

import UIKit

protocol BackFeedDelegate: AnyObject {
    func navigatePreviousPage(newOrderCoordinator: PostCoordinator)
}

class PostCoordinator: RootCoordinatorProtocol, PostCoordinatorDelegate, BackPostCoordinatorDelegate {
    
    var childs = [RootCoordinatorProtocol]()
    weak var delegate: BackFeedDelegate?
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startFeed() {
        let postViewController: PostViewController = PostViewController()
        postViewController.navigationItem.title = postViewController.titlePost
        postViewController.coordinator = self
        self.navigationController.pushViewController(postViewController, animated: true)
    }
    
    func navigateNextPage() {
        let infoCoordinator: InfoCoordinator = InfoCoordinator(navigationController: navigationController)
        infoCoordinator.delegate = self
        childs.append(infoCoordinator)
        infoCoordinator.openInfoViewController()
    }
    
    func navigatePreviousPage(newCoordinator: InfoCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childs.removeLast()
    }
}
