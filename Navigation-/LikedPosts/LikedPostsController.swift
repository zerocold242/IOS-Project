//
//  LikedPostsController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 17.03.2023.
//

import UIKit
import StorageService

class LikedPostsController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        CoreDataManager.shared.likedPosts = CoreDataManager.shared.searchLikedPosts(searchString: searchController.searchBar.text)
        tableView.reloadData()
    }
    
    private let reuseID = String(describing: PostTableViewCell.self)
    var doubleTap: ((_ post: PostStruct) -> Void)?
    let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
        self.title = "Liked Posts"
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .never
        searchController.searchResultsUpdater = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func removePost(post: LikedPost) {
        CoreDataManager.shared.remove(likedPost: post)
        print("Post is removed")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.likedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? PostTableViewCell
        else {return PostTableViewCell()}
        
        let likedPost = CoreDataManager.shared.likedPosts[indexPath.row]
        let post = PostStruct(author: likedPost.author ?? "",
                              description: likedPost.postDescription ?? "",
                              image: likedPost.image ?? "",
                              likes: likedPost.likes,
                              views: likedPost.views)
        
        cell.post = post
        cell.doubleTap = { [weak self] post in
            let alert = UIAlertController(title: "", message: "Удалить публикацию из избранного?", preferredStyle: .alert)
            let alertOK = UIAlertAction(title: "OK", style: .default, handler:  { action in
                self?.removePost(post: likedPost)
                tableView.reloadData()
            })
            let alertCancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(alertOK)
            alert.addAction(alertCancel)
            self?.present(alert, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let likedPost = CoreDataManager.shared.likedPosts[indexPath.row]
            
            self.removePost(post: likedPost)
            tableView.reloadData()
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
