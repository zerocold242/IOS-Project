//
//  InfoViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 27.05.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    var url = "https://jsonplaceholder.typicode.com/todos/\(Int.random(in: 1...10))"
    var urlPlanets = "https://swapi.dev/api/planets/1"
    
    private lazy var taskOneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .blue
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var taskTwoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .blue
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupButton() {
        let alertButton = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - 100,
                                                 y: self.view.bounds.height / 2 - 25,
                                                 width: 200,
                                                 height: 50))
        alertButton.setTitle("Alert", for: .normal)
        alertButton.setTitleColor(.lightGray, for: .highlighted)
        alertButton.backgroundColor = .blue
        alertButton.layer.cornerRadius = 12
        alertButton.addTarget(self, action: #selector(setupAlert), for: .touchUpInside)
        alertButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        self.view.addSubview(alertButton)
    }
    
    // 1.2 DT: метод парсит json и отображает title taskOneLabel
//    func urlSession() {
//        let session = URLSession.shared
//        guard let url = URL(string: url) else {return}
//        let task = session.dataTask(with: url) { data , responce, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            if (responce as? HTTPURLResponse)?.statusCode != 200 {
//                print("StatusCode = \((responce as? HTTPURLResponse)?.statusCode ?? 0)")
//                return
//            }
//            guard let data = data  else {
//                print("Data = nil")
//                return
//            }
//            do {
//                if let jsonData = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
//                    guard let title = jsonData["title"] as? String else {return}
//                    DispatchQueue.main.async {
//                        self.taskOneLabel.text = title
//                    }
//                }
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//    }
    
    // 1.2 DT: метод отображает период обращения Татуина 


    func dataPlanet() {
            let session = URLSession.shared
            guard let url = URL(string: "https://swapi.dev/api/planets/1") else {return}
            let task = session.dataTask(with: url) { [self]data, responce, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if (responce as? HTTPURLResponse)?.statusCode != 200 {
                    print("StatusCode = \((responce as? HTTPURLResponse)?.statusCode ?? 0)")
                    return
                }
                guard let data = data  else {
                    print("Data = nil")
                    return
                }
                do {
       
                    let model = try JSONDecoder().decode(PlanetModel.self, from: data)
                    DispatchQueue.main.async { [self] in
                        taskTwoLabel.text = " \(model.name)' rotation period = \(model.orbitalPeriod)"
                    }
               
                } catch let error as NSError {
                        print("error: \(error.localizedDescription)")
                }
            }
            task.resume()
        }


    
    private func setupView() {
        view.addSubview(taskOneLabel)
        view.addSubview(taskTwoLabel)
        NSLayoutConstraint.activate([
            taskOneLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskOneLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            taskOneLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16 ),
            taskOneLabel.heightAnchor.constraint(equalToConstant: 50 ),
            
            taskTwoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskTwoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            taskTwoLabel.topAnchor.constraint(equalTo: taskOneLabel.bottomAnchor, constant: 16 ),
            taskTwoLabel.heightAnchor.constraint(equalToConstant: 50 )
        ])
    }
    
    @objc private func setupAlert() {
        let title = "Warning!"
        let message = "Была нажата кнопка Alert в InfoViewController"
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            print("Нажата кнопка Cancel")
        }
        
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in
            print("Нажата кнопка Ок")
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        setupButton()
        setupView()
      //  urlSession()
       // dataPlanet()
    }
}
