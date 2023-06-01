//
//  LikedPostsController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 17.03.2023.
//

import UIKit
import StorageService
import CoreData

class LikedPostsController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {
    
    private let reuseID = String(describing: PostTableViewCell.self)
    var doubleTap: ((_ post: PostStruct) -> Void)?
    let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var fetchResultController: NSFetchedResultsController<LikedPost> = {
        let fetchRequest: NSFetchRequest<LikedPost> = LikedPost.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "author", ascending: true)//без дескриптора почему-то все крашится
        fetchRequest.sortDescriptors = [sortDescriptor]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataManager.shared.viewContext,
                                             sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            let predicate = NSPredicate(format: "author CONTAINS[c] %@", searchText)
            fetchResultController.fetchRequest.predicate = predicate
        } else {
            fetchResultController.fetchRequest.predicate = nil
        }
        do {
            try fetchResultController.performFetch()
        } catch {
            print("Failed to fetch objects: \(error)")
        }
        tableView.reloadData()
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: reuseID
        )
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.title = ~LocalizedKeys.LPNavTitle.rawValue
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .never
        searchController.searchResultsUpdater = self
        try? fetchResultController.performFetch()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = ~LocalizedKeys.LPSearchTitle.rawValue
        definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func removePost(post: LikedPost) {
        CoreDataManager.shared.remove(likedPost: post)
        print("Post is removed")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? PostTableViewCell
        else {return PostTableViewCell()}
        
        let likedPost = fetchResultController.object(at: indexPath)
        let post = PostStruct(author: likedPost.author ?? "",
                              description: likedPost.postDescription ?? "",
                              image: likedPost.image ?? "",
                              likes: likedPost.likes,
                              views: likedPost.views)
        
        cell.post = post
        cell.doubleTap = { [weak self] post in
            let alert = UIAlertController(title: "", message: ~LocalizedKeys.LPRemoveAlertTitle.rawValue, preferredStyle: .alert)
            let alertOK = UIAlertAction(title: ~LocalizedKeys.infoActionOk.rawValue, style: .default, handler:  { action in
                self?.removePost(post: likedPost)
                tableView.reloadData()
            })
            let alertCancel = UIAlertAction(title: ~LocalizedKeys.infoActionCancel.rawValue, style: .cancel)
            alert.addAction(alertOK)
            alert.addAction(alertCancel)
            self?.present(alert, animated: true)
        }
        return cell
    }
    
    //как только в базе что-то меняется fetchResultsController обращается к этому методу.
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        //плавная анимация
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadData()
        @unknown default:
            tableView.reloadData()
        }
    }
    
    //метод не позволяет ячейке выделяться навечно после тапа
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: ~LocalizedKeys.LPDeleteSwipe.rawValue) { (action, view, completionHandler) in
            
            let likedPost = self.fetchResultController.object(at: indexPath)
            self.removePost(post: likedPost)
            tableView.reloadData()
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
