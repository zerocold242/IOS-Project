//
//  PhotosViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 23.06.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    var photoGallery: [UIImage] = []
    
    // 5 INT:
    var publisherFacade = ImagePublisherFacade()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        collection.backgroundColor = .white
        return collection
    }()
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //photoGallery = PhotoGallery.myPhotos
        setupCollectionView()
        // 5 INT: подписка на паблишер для заполнения экрана коллекции через паттерн observer
        publisherFacade.subscribe(self)
        // 5 INT: наполнение коллекции с таймером:
        publisherFacade.addImagesWithTimer(time: 0.7, repeat: 19, userImages: PhotoGallery.myPhotos)
    }
    
    //5 INT: завершение подписки полсе кончания работы
    override func viewDidDisappear(_ animated: Bool) {
        publisherFacade.removeSubscription(for: self)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as? PhotosCollectionViewCell
        else { return UICollectionViewCell() }
        cell.photo.image = photoGallery[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let x = (collectionView.bounds.width - 8 * 4) / 3
        return CGSize(width: x, height: x)
    }
}

// 5 INT: реализация метода протокола ImageLibrarySubscriber
extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
       photoGallery = images
        collectionView.reloadData()
    }
}


