//
//  feedModel.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 19.09.2022.
//

import Foundation

class FeedModel {
    let secretWord = "MVC"
    func check(word: String) -> Bool {
        guard word == secretWord else { return false}
        return true
    }
}
