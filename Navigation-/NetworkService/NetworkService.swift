//
//  NetworkService.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 10.10.2022.
//

//import Foundation
//
////iosDT1.1
//struct NetworkService {
//
//    static func urlParser(_ url: URL) {
//        let session = URLSession.shared
//        let task = session.dataTask(with: url) {
//            data, response, error in
//            if let error = error {
//                print("Web service didn't respond: \(error.localizedDescription)")
//                //Без  wifi: Code=-1009 "The Internet connection appears to be offline."
//            } else {
//                guard let data = data else { return }
//                print("Data: \(String(decoding: data, as: UTF8.self))")
//                if let response = response as? HTTPURLResponse {
//                    print("Response header fields: \(response.allHeaderFields)")
//                    print("Status code: \(response.statusCode)")
//                }
//            }
//        }
//        task.resume()
//    }
//}
