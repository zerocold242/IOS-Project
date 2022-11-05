//
//  SharedAlert.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 31.10.2022.
//

import Foundation
import UIKit
//class SharedAlert: NSObject {
//static let sharedAlert = SharedAlert()
//
//    //Show alert
//    func alert(view: UIViewController, title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
//        })
//        alert.addAction(defaultAction)
//        DispatchQueue.main.async(execute: {
//            view.present(alert, animated: true)
//        })
//    }
//
//    private override init() {
//    }
//}

extension UIAlertController {
    class func alert(title:String, msg:String, target: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
        (result: UIAlertAction) -> Void in
        })
        target.present(alert, animated: true, completion: nil)
    }
}
