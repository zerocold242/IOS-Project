//
//  NetworkService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 10.10.2022.
//

import Foundation

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        
        switch configuration {
        case .urlOne(let data):
            guard let url = URL(string: data) else {return}
            urlParser(url)
        case .urlTwo(let data):
            guard let url = URL(string: data) else {return}
            urlParser(url)
        case .urlThree(let data):
            guard let url = URL(string: data) else {return}
            urlParser(url)
        }
    }
    
   static func urlParser(_ url: URL) {
         
    }
}
