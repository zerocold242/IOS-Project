//
//  ProfileViewModel.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 12.10.2022.
//

import Foundation
import UIKit

final class ProfileViewModel {
    
    var currentUser: User
    let profileHeaderView = ProfileHeaderView()
    var postsData: [PostModel] = []
    
    init(currentUser: User ) {
        self.currentUser = currentUser
    }
    
    func userSetting() {
        profileHeaderView.showUser(userImageAvatar: currentUser.avatar,
                                   fullName: currentUser.fullName!,
                                   status: currentUser.userStatus!)
    }
    
    func postSetting() {
        postsData = posts
    }
}

