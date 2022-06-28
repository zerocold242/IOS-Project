//
//  PhotosTableViewCell.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 23.06.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var photosLabel: UILabel = {
        
        var label = UILabel()
        label.textColor = .black
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var arrowIcon: UIImageView = {
        
        let icon = UIImageView()
        icon.image = UIImage(systemName: "arrow.right")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = .black
        
        return icon
    }()
    
    private lazy var photoImageView1: UIImageView = {
        
        let image = UIImageView()
        image.image = PhotoGallery.myPhotos[0]
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var photoImageView2: UIImageView = {
        
        let image = UIImageView()
        image.image = PhotoGallery.myPhotos[1]
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var photoImageView3: UIImageView = {
        
        let image = UIImageView()
        image.image = PhotoGallery.myPhotos[2]
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var photoImageView4: UIImageView = {
        
        let image = UIImageView()
        image.image = PhotoGallery.myPhotos[3]
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var previewStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupPhotosTableViewCell()
    }
    
    private func setupPhotosTableViewCell() {
        
        contentView.addSubview(previewStackView)
        contentView.addSubview(photosLabel)
        contentView.addSubview(arrowIcon)
        
        previewStackView.addArrangedSubview(photoImageView1)
        previewStackView.addArrangedSubview(photoImageView2)
        previewStackView.addArrangedSubview(photoImageView3)
        previewStackView.addArrangedSubview(photoImageView4)
        
        photosLabel.setContentHuggingPriority(.required, for: .vertical)
        
        [photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
         photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
         
         previewStackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
         previewStackView.leadingAnchor.constraint(equalTo: photosLabel.leadingAnchor),
         previewStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
         previewStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
         
         photoImageView1.widthAnchor.constraint(equalTo: previewStackView.heightAnchor),
         photoImageView2.widthAnchor.constraint(equalTo: previewStackView.heightAnchor),
         photoImageView3.widthAnchor.constraint(equalTo: previewStackView.heightAnchor),
         photoImageView4.widthAnchor.constraint(equalTo: previewStackView.heightAnchor),
         
         arrowIcon.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
         arrowIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
         arrowIcon.heightAnchor.constraint(equalTo: photosLabel.heightAnchor),
         arrowIcon.widthAnchor.constraint(equalTo: arrowIcon.heightAnchor)
         ]
            .forEach({$0.isActive = true})
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

