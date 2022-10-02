//
//  InfoCoordinator.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 02.10.2022.
//

import UIKit

protocol BackPostCoordinatorDelegate: AnyObject {
    func navigatePreviousPage(newCoordinator: InfoCoordinator)
}

class InfoCoordinator: RootCoordinatorProtocol {
    
    weak var delegate: BackPostCoordinatorDelegate?
    var childs = [RootCoordinatorProtocol]()
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openInfoViewController() {
        let infoViewController: InfoViewController = InfoViewController()
        self.navigationController.present(infoViewController, animated: true, completion: nil)
    }
}


