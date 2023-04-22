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
    
    var backgroundViewContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    //4. Запрос постов из контекста/перезагрузка контекста
    var likedPosts: [LikedPost] = []
    
    func fetchLikedPosts(searchString: String? = nil) {
        let request = LikedPost.fetchRequest()
        likedPosts = (try? viewContext.fetch(request)) ?? []
    }
    
    //запрос постов из контекста с предикатом для поискового запроса
    func searchLikedPosts(searchString: String? = nil) -> [LikedPost] {
        let request = LikedPost.fetchRequest()
        if let searchString, searchString != "" {
            request.predicate = NSPredicate(format: "author contains[c] %@",  searchString)
        }
        print("context reloaded")
        return (try? viewContext.fetch(request)) ?? []
    }
    
    //перезагрузка/отображение контекста с предикатом для проверки на дубли в сохраненных постах
    func getPost(by description: String, context: NSManagedObjectContext) -> LikedPost? {
        let fetchRequest = LikedPost.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "postDescription == %@", description)
        return (try? context.fetch(fetchRequest))?.first
    }
    
    //удаление из контекста
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
    
    // Сохранение  поста в backgroundContext
    func createPostIntoBackground(post: PostStruct, completion: (()->())?) {
        persistentContainer.performBackgroundTask {  contextBackground in
            if self.getPost(by: post.description, context: contextBackground) == nil {
                
                let newLikedPost = LikedPost(context: contextBackground)
                newLikedPost.author = post.author
                newLikedPost.postDescription = post.description
                newLikedPost.image = post.image
                newLikedPost.likes = Int16(post.likes)
                newLikedPost.views = Int16(post.views)
            } else {
                DispatchQueue.main.async {
                    SharedAlert.shared.showAlert(alertTitle: "Внимание!",
                                                 alertMessage: "Вы уже добавляли эту публикацию в избранное")
                }
            }
            try? contextBackground.save()
            completion?()
            print("backgroundPost created")
            self.fetchLikedPosts()
        }
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



