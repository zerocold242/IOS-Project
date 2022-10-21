//
//  DownloadManager.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 21.10.2022.
//

import Foundation


final class DownloadManager {
    
    //var url = "https://jsonplaceholder.typicode.com/todos/1"
    public var shared = DownloadManager()
    var dataInfoModel = DataInfo(userId: 1,
                                id: 1,
                                title: "",
                                completed: false)
  // 1.2 DT: метод парсит json и отображает title в InfoViewController/taskOneLabel
   //func urlSession() {
   //    let session = URLSession.shared
   //    guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(Int.random(in: 1...10))") else {return}
   //    let task = session.dataTask(with: url) { data , responce, error in
   //        if let error = error {
   //            print(error.localizedDescription)
   //            return
   //        }
  //
   //        if (responce as? HTTPURLResponse)?.statusCode != 200 {
   //            print("StatusCode = \((responce as? HTTPURLResponse)?.statusCode ?? 0)")
   //            return
   //        }
   //        guard let data = data  else {
   //            print("Data = nil")
   //            return
   //        }
   //        do {
   //            if let jsonData = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
   //                guard let title = jsonData["title"] as? String else {return}
   //                DispatchQueue.main.async {
   //                    self.taskOneLabel.text = title
   //                }
   //            }
   //        } catch {
   //            print(error)
   //        }
   //    }
   //    task.resume()
  // }
    
   // func urlSession() {
   //     let session = URLSession.shared
   //     guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(Int.random(in: 1...10))") else {return}
   //     let task = session.dataTask(with: url) { data , responce, error in
   //         if let error = error {
   //             print(error.localizedDescription)
   //             return
   //         }
   //
   //         if (responce as? HTTPURLResponse)?.statusCode != 200 {
   //             print("StatusCode = \((responce as? HTTPURLResponse)?.statusCode ?? 0)")
   //             return
   //         }
   //         guard let data = data  else {
   //             print("Data = nil")
   //             return
   //         }
   //         do {
   //              let jsonData = try JSONSerialization.jsonObject(with: data, options: [] )
   //                 if let object = jsonData as? [String: Any] {
   //                     self.dataInfoModel.userId = object["userId"] as? Int ?? 0
   //                     self.dataInfoModel.id = object["id"] as? Int ?? 0
   //                     self.dataInfoModel.completed = object["completed"] as? Bool ?? false
   //                     self.dataInfoModel.title = object["title"] as? String ?? "empty"
   //                     print("\(self.dataInfoModel.userId)")
   //             }
   //         } catch {
   //             print(error)
   //         }
   //     }
   //     task.resume()
   // }
}



