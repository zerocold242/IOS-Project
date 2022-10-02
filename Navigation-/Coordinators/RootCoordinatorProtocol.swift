//
//  RootCoordinator.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 29.09.2022.
//

import Foundation
import UIKit

// INT 7.1: базовый координатор
protocol RootCoordinatorProtocol {
    var childs: [RootCoordinatorProtocol] { get set }
}

