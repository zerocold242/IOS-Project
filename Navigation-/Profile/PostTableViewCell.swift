//
//  PostTableViewCell.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 20.06.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    //двойной клик на ячейку поста
    var doubleTap: ((_ post: PostStruct) -> Void)?
    
    var post: PostStruct? {
        didSet {
            authorLablel.text = post?.author
            descriptionLablel.text = post?.description
            imageImageView.image = UIImage(named: post?.image ?? "logo.png")
            likesLablel.text = "Likes: \(post?.likes ?? 0)"
            viewsLablel.text = "Views: \(post?.views ?? 0)"
        }
    }
    
     lazy var  authorLablel: UILabel = {
        
        let authLabel = UILabel()
        authLabel.textColor = .black
        authLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        authLabel.numberOfLines = 2
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        return authLabel
    }()
    
     lazy var  descriptionLablel: UILabel = {
        
        let descLabel = UILabel()
        descLabel.textColor = .systemGray
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        return descLabel
    }()
    
     lazy var imageImageView: UIImageView = {
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
     lazy var likesLablel: UILabel = {
        
        let likeLabel = UILabel()
        likeLabel.textColor = .black
        likeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        return likeLabel
    }()
    

     lazy var viewsLablel: UILabel = {

        let viewLabel = UILabel()
        viewLabel.textColor = .black
        viewLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(postTapped))
        tapGestureRecognizer.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(tapGestureRecognizer)
        setupPostTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func postTapped() {
        if let doubleTapped = self.doubleTap,
           let post = post {
            doubleTapped(post)
            print("double tapped, post created")
        }
    }
    
    private func setupPostTableViewCell() {
        contentView.addSubview(authorLablel)
        contentView.addSubview(descriptionLablel)
        contentView.addSubview(imageImageView)
        contentView.addSubview(likesLablel)
        contentView.addSubview(viewsLablel)
        
        authorLablel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLablel.setContentHuggingPriority(.required, for: .vertical)
        likesLablel.setContentHuggingPriority(.required, for: .vertical)
        viewsLablel.setContentHuggingPriority(.required, for: .vertical)
        
        
        [authorLablel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
         authorLablel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
         authorLablel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
         authorLablel.heightAnchor.constraint(equalToConstant: 16),
         
         imageImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
         imageImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
         imageImageView.topAnchor.constraint(equalTo: authorLablel.bottomAnchor, constant: 16),
         
         imageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         imageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         
         descriptionLablel.topAnchor.constraint(equalTo: imageImageView.bottomAnchor, constant: 16),
         descriptionLablel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -48),
         descriptionLablel.leadingAnchor.constraint(equalTo: authorLablel.leadingAnchor),
         descriptionLablel.trailingAnchor.constraint(equalTo: authorLablel.trailingAnchor),
         
         likesLablel.topAnchor.constraint(equalTo: descriptionLablel.bottomAnchor, constant: 16),
         likesLablel.leadingAnchor.constraint(equalTo: authorLablel.leadingAnchor),
         likesLablel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
         
         viewsLablel.topAnchor.constraint(equalTo: descriptionLablel.bottomAnchor, constant: 16),
         viewsLablel.trailingAnchor.constraint(equalTo: authorLablel.trailingAnchor),
        ] .forEach { $0.isActive = true }
    }
}
