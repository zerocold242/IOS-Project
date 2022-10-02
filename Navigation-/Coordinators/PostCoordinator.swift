//
//  PostCoordinator.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 02.10.2022.
//

import UIKit

protocol BackFeedDelegate: AnyObject {
    func navigateToPreviousPage(newOrderCoordinator: PostCoordinator)
}

class PostCoordinator: RootCoordinatorProtocol, PostViewControllerCoordinatorDelegate {
    
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
    
    func navigateNextPage() {}
}
