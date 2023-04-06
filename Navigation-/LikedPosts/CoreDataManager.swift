//
//  CoreDataManager.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 17.03.2023.
//

import Foundation
import CoreData
import StorageService

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    init() {
        fetchLikedPosts()
    }
    
    //1. создание контейнера
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LikedPostModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    //4. Запрос постов из контекста
    var likedPosts: [LikedPost] = []
    
    func fetchLikedPosts() {
        let request = LikedPost.fetchRequest()
        likedPosts = (try? viewContext.fetch(request)) ?? []
        print("context reloaded")
    }
    
    func remove(likedPost: LikedPost) {
        viewContext.delete(likedPost)
        saveContext()
        fetchLikedPosts()
        print("post removed")
    }
    
    //3. Сохранение  поста в контекст
    func createNewLikedPost(post: PostStruct) {
        let newLikedPost = LikedPost(context: viewContext)
        newLikedPost.author = post.author
        newLikedPost.postDescription = post.description
        newLikedPost.image = post.image
        newLikedPost.likes = Int16(post.likes)
        newLikedPost.views = Int16(post.views)
        saveContext()//сохранение изменений в контексте
        fetchLikedPosts()//перезагружаем контекст
        print("Post created")
    }
    
    //2. сохранение изменений во вью контексте
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        print("context saved")
    }
}



