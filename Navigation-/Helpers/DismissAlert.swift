//
//  DismissAlert.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 10.05.2023.
//

import Foundation
import UIKit

class DismissAlert {
    
    static let shared = DismissAlert()
    
    func dismissAlert(viewController: UIViewController, titles: String, message: String) {
        
        let alert = UIAlertController(title: titles, message: message, preferredStyle: .alert)
        
        viewController.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
