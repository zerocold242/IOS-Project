//
//  PostTableViewCell.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 20.06.2022.
//

import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    private lazy var imageProcessor = ImageProcessor()
    
    var post: PostStruct? {
        didSet {
            if let post = post {
                authorLabel.text = post.author
                descriptionLabel.text = post.description
                imageImageView.image = UIImage(named: post.image )
                likesLabel.text = "Likes: \(post.likes )"
                viewsLabel.text = "Views: \(post.views )"
                
                if let image = UIImage(named: post.image) {
                    imageProcessor.processImage(sourceImage: image, filter: post.filter) {
                        image in imageImageView.image = image
                    }
                }
            }
        }
    }
    
    private lazy var  authorLabel: UILabel = {
        let authLabel = UILabel()
        authLabel.textColor = .black
        authLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        authLabel.numberOfLines = 2
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        return authLabel
    }()
    
    private lazy var  descriptionLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = .systemGray
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        return descLabel
    }()
    
    private lazy var imageImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var likesLabel: UILabel = {
        let likeLabel = UILabel()
        likeLabel.textColor = .black
        likeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        return likeLabel
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewLabel = UILabel()
        viewLabel.textColor = .black
        viewLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupPostTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPostTableViewCell() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(imageImageView)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        authorLabel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
        likesLabel.setContentHuggingPriority(.required, for: .vertical)
        viewsLabel.setContentHuggingPriority(.required, for: .vertical)
        
        
        [authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
         authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
         authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
         authorLabel.heightAnchor.constraint(equalToConstant: 16),
         
         imageImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
         imageImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
         imageImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
         
         imageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         imageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         
         descriptionLabel.topAnchor.constraint(equalTo: imageImageView.bottomAnchor, constant: 16),
         descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -48),
         descriptionLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
         descriptionLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
         
         likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
         likesLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
         likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
         
         viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
         viewsLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),

        ] .forEach { $0.isActive = true }
    }
}
