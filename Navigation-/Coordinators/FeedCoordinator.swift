//
//  FeedCoordinator.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 02.10.2022.
//

import UIKit

class FeedCoordinator: RootCoordinatorProtocol, FeedCoordinatorDelegate {
    
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
    
    func navigateNextPage() {}
    
}

