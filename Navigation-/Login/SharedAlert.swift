//
//  SharedAlert.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 31.10.2022.
//

import Foundation
import UIKit
import StorageService


//Универсальный Алерт
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

class SharedAlert {
    
    static let shared = SharedAlert()
    
    func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let actionOne = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(actionOne)
        UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
    }
}



