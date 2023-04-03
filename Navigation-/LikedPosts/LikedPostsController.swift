//
//  LikedPostsController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 17.03.2023.
//

import UIKit
import StorageService

class LikedPostsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let reuseID = String(describing: PostTableViewCell.self)
    var doubleTap: ((_ post: PostStruct) -> Void)?
    
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
    
    private func setUpGestureRecognizer() {
        let doubleTapOnCell = UITapGestureRecognizer(target: self, action: #selector(doubleTapRemove))
        doubleTapOnCell.numberOfTapsRequired = 2
        tableView.addGestureRecognizer(doubleTapOnCell)
    }
    
    //  @objc private func postTapped() {
    //      if let doubleTapped = self.doubleTap,
    //         let post = post {
    //          doubleTapped(post)
    //          print("double tapped, post created")
    //      }
    //  }
    
    @objc private func doubleTapRemove(_ tapGesture: UITapGestureRecognizer) {
        if tapGesture.state == .ended {
            let location = tapGesture.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: location),
               let _ = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
                let post = CoreDataManager.shared.likedPosts[indexPath.row]
                // cell.post = post
                CoreDataManager.shared.remove(likedPost: post)
                tableView.reloadData()
            }
        }
    }
    
    //  @objc private func doubleTapRemove(_ tapGesture: UITapGestureRecognizer) {
    //         if tapGesture.state == .ended {
    //             let location = tapGesture.location(in: self.tableView)
    //             if let indexPath = tableView.indexPathForRow(at: location),
    //                let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell,
    //                let post = cell.post {
    //                 CoreDataManager.shared.remove(likedPost: post)
    //                 tableView.reloadData()
    //                 print("Post removed")
    //             }
    //         }
    //     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpGestureRecognizer()
        self.title = "Liked Posts"
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: reuseID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.likedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? PostTableViewCell
        else {return PostTableViewCell()}
        
        let likedPost = CoreDataManager.shared.likedPosts[indexPath.row]
        let post = PostStruct(author: likedPost.author ?? "",
                              description: likedPost.description,
                              image: likedPost.image ?? "",
                              likes: likedPost.likes,
                              views: likedPost.views)
        cell.post = post
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
