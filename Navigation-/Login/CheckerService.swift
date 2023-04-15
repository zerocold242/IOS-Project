//
//  CheckerService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 30.10.2022.
//

import Foundation
//import FirebaseAuth
import UIKit
import RealmSwift

class CheckerService {
    
    static let shared = CheckerService()
    
    func signUp( withEmail: String, password: String) {
        let realm = try? Realm()
        do {
            try realm?.write({
                let login = RealmLoginModel(password: password, login: withEmail)
                realm?.add(login)
            })
        } catch let signedUpError as NSError {
            print("Error signed Up: %@", signedUpError)
        }
        
        
        // func signOut() {
        //let realm = try! Realm()
        //  let user = realm.objects(User.self)[0]
        //  try! realm.write({
        //      realm.delete(user)
        //  })
        // }
        
        
    }
}




