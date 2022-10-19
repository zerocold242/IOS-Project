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
    
    // 8 INT: cвойства для дз 8
    private let imageProcessor = ImageProcessor()
    private var threadPhotosArray: [UIImage] = []
    private var count: Double = 0
    private var timer: Timer?
    
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
    
    // 8 INT: универсальный метод для всплывашек
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // 8 INT метод обрабатывает фильтром и передает массив исходных изображений в processImagesOnThread + таймер
    private func onThread() {
        imageProcessor.processImagesOnThread(sourceImages: photoGallery,
                                             filter: .colorInvert,
                                             qos: .userInteractive) { [self] completion in
            for myPhoto in completion {
                if let photo = myPhoto {
                    threadPhotosArray.append(UIImage(cgImage: photo))
                    photoGallery = threadPhotosArray
                    DispatchQueue.main.async {
                        collectionView.reloadData()
                    }
                }
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil, repeats: true)
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // 8 INT: метод выводит текущие значения в алерт и принт
    @objc func updateTimer() {
        count += 0.01
        if threadPhotosArray.count > 0 {
            showAlert(title: "время использования метода processImagesOnThread при текущем qos: ", message: "\(self.count) секунд")
            print("\(self.count) секунд")
            timer!.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        photoGallery = PhotoGallery.myPhotos
        setupCollectionView()
        onThread()
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
