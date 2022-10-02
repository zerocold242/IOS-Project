//
//  FeedCoordinator.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 02.10.2022.
//

import UIKit

class FeedCoordinator: RootCoordinatorProtocol, FeedCoordinatorDelegate, BackFeedDelegate {
    
    weak var rootCoordinator: RootCoordinator?
    var childs = [RootCoordinatorProtocol]()
    let navigationController: UINavigationController
    
    required init() {
        self.navigationController = .init()
    }
    
    func startFeedViewController() {
        let feedViewController: FeedViewController = FeedViewController()
        feedViewController.navigationItem.title = "Feed"
        feedViewController.coordinator = self
        self.navigationController.viewControllers = [feedViewController]
    }
    
    func navigateNextPage() {
        let postCoordinator = PostCoordinator(navigationController: navigationController)
        postCoordinator.delegate = self
        childs.append(postCoordinator)
        postCoordinator.startFeed()
    }
    
    func navigatePreviousPage(newOrderCoordinator: PostCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childs.removeLast()
    }
    
}

