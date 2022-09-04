//
//  ProfileViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//
import StorageService
import UIKit

class ProfileViewController: UIViewController {
    
    let userService: UserService
    let userName: String
    
    init (userService: UserService, userName: String) {
        self.userService = userService
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var  tableView = UITableView.init(frame: .zero, style: .grouped)
    
    private lazy var profileHeaderView = ProfileHeaderView()
    
    var postsData: [PostStruct] = []
    
    private var backgroundView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var closeButton: UIButton = {
        let close = UIButton()
        let img1 = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        close.setImage(img1, for: .normal)
        close.tintColor = .white
        close.translatesAutoresizingMaskIntoConstraints = false
        close.alpha = 0
        close.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
        return close
    }()
    
    private func showUser() {
        if let user = userService.getLogin(login: userName) {
        profileHeaderView.fullNameLabel.text = user.fullName
            profileHeaderView.statusLabel.text = user.userStatus
            profileHeaderView.avatarImageView.image = user.avatar
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(profileHeaderView.avatarImageView)
        backgroundView.addSubview(closeButton)
        
        [backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
         backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
         backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
         backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         closeButton.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 15),
         closeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -15)]
            .forEach({$0.isActive = true})
    }
    
    private  func setupTableView() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderView")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        [tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
         tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
            .forEach({$0.isActive = true})
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func gesture() {
        let gesture = UITapGestureRecognizer()
        gesture.cancelsTouchesInView = false
        gesture.addTarget(self, action: #selector(self.gestureAction))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc private func gestureAction() {
        self.view.endEditing(true)
    }
    
    @objc private func tapProcess() {
        let avatar = profileHeaderView.avatarImageView
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.setupBackgroundView()
            if UIDevice.current.orientation.isPortrait{
                NSLayoutConstraint.activate([
                    avatar.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                    avatar.heightAnchor.constraint(equalTo: self.view.widthAnchor),
                    avatar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    avatar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                ])
                
            } else {
                
                NSLayoutConstraint.activate([
                    avatar.widthAnchor.constraint(equalTo: self.view.heightAnchor),
                    avatar.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                    avatar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    avatar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    avatar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
                ])
            }
            
            self.view.layoutIfNeeded()
            
        } completion: { finished in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.closeButton.alpha = 1
                self.profileHeaderView.avatarImageView.layer.cornerRadius = 0
            }
        }
    }
    
    @objc private func closeAvatar() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.closeButton.alpha = 0
            self.profileHeaderView.avatarImageView.layer.cornerRadius = 110/2
            self.view.layoutIfNeeded()
        } completion: { finished in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.profileHeaderView.addSubview(self.profileHeaderView.avatarImageView)
                
                self.profileHeaderView.avatarImageView.leftAnchor.constraint(equalTo: self.profileHeaderView.leftAnchor, constant: 16).isActive = true
                self.profileHeaderView.avatarImageView.topAnchor.constraint(equalTo: self.profileHeaderView.topAnchor, constant: 16).isActive = true
                self.profileHeaderView.avatarImageView.widthAnchor.constraint(equalToConstant: 110).isActive = true
                self.profileHeaderView.avatarImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
                self.backgroundView.removeFromSuperview()
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
#if DEBUG
        view.backgroundColor = .red
#else
        view.backgroundColor = .systemGray6
#endif
        view.addSubview(tableView)
        gesture()
        postsData = posts
        setupTableView()
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return 1
        case 2:
            return postsData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            cell.post = postsData[indexPath.row]
            return cell
        }
        
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            let photoViewController = PhotosViewController()
            photoViewController.title = "Photo Gallery"
            navigationController?.pushViewController(photoViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard (tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderView") as? ProfileHeaderView) != nil
        else {return UIView()}
        if section == 0 {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapProcess))
            self.profileHeaderView.avatarImageView.addGestureRecognizer(tapGesture)
            return profileHeaderView
            
        } else {
            
            return nil
        }
    }
}


