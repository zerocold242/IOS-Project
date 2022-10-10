//
//  AppConfiguration.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 10.10.2022.
//

import Foundation

enum AppConfiguration: String, CaseIterable {
    case urlOne = "https://swapi.dev/api/people/8"
    case urlTwo = "https://swapi.dev/api/starships/3"
    case urlThree = "https://swapi.dev/api/planets/5"
    
    static func randomUrl() -> String {
        guard let url = AppConfiguration.allCases.randomElement()?.rawValue
        else { return "URL not found" }
        return url
    }
}
