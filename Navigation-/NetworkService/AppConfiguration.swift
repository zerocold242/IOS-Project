//
//  AppConfiguration.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 10.10.2022.
//

import Foundation

enum AppConfiguration: CaseIterable {
    
    case urlOne(String)
    case urlTwo(String)
    case urlThree(String)
    
    typealias AllCases = [AppConfiguration]
    
    static var allCases: AllCases {
        return [
            .urlOne( "https://swapi.dev/api/people/8"),
            .urlTwo("https://swapi.dev/api/starships/3"),
            .urlThree("https://swapi.dev/api/planets/5")]
    }
}
