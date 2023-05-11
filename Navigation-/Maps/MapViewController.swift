//
//  MapViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 02.05.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        let pointsOfInterestFilter = MKPointOfInterestFilter() //отображение точек интересов(кафе, банкоматы и т д)
        mapView.pointOfInterestFilter = pointsOfInterestFilter
        
        //при запуске карта покажет Москву
        let initialLocation = CLLocationCoordinate2D(
            latitude: 55.75222,
            longitude: 37.61556
        )
        
        //установка центра карты
        mapView.setCenter(initialLocation, animated: false)
        
        //масштаб региона, который будет показан на карте при запуске
        let region = MKCoordinateRegion(
            center: initialLocation,
            latitudinalMeters: 100_00,
            longitudinalMeters: 100_00
        )
        
        mapView.setRegion(region, animated: false)
        
        return mapView
    }()
    
    private func setUpDeletePinsButton() {
        // Создаем кнопку в навигационном баре
        let deleteButton = UIBarButtonItem(title: "Delete All Pins",
                                           style: .plain, target: self,
                                           action: #selector(deleteAllPins))
        self.navigationItem.rightBarButtonItem = deleteButton
    }
    
    private func findUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    private func longPress() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(gesture:)))
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func addAnnotation(gesture: UILongPressGestureRecognizer) {
        
        let annotation = MKPointAnnotation()
        if gesture.state == .ended {
            let point = gesture.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            annotation.title = "New Point"
        }
    }
    
    @objc private func deleteAllPins() {
        // Удаляем все пины с карты и их ассоциированные данные
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Get selected annotation
        guard let annotation = view.annotation else { return }
        
        let alertController = UIAlertController(title: "Navigate", message: "Do you want to navigate to this location?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let navigateAction = UIAlertAction(title: "Navigate", style: .default) { (action) in
            //переход в навигатор для прокладки маршрута
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate))
            destination.name = annotation.title ?? "Destination"
            let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            MKMapItem.openMaps(with: [destination], launchOptions: options)
            // guard let annotation = view.annotation else { return }
            //       let destination = MKPlacemark(coordinate: annotation.coordinate)
            //       let request = MKDirections.Request()
            //       request.source = MKMapItem.forCurrentLocation()
            //       request.destination = MKMapItem(placemark: destination)
            //       request.transportType = .automobile // можно изменить на .walking
            //       let directions = MKDirections(request: request)
            // directions.calculate { [weak self] (response, error) in
            //     guard let route = response?.routes.first else { return }
            //     self?.mapView.addOverlay(route.polyline)
            //     self?.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            // }
        }
        alertController.addAction(navigateAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 5
        return renderer
    }
    
    private func setUpMapView() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        setUpMapView()
        findUserLocation()
        longPress()
        setUpDeletePinsButton()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

extension  MapViewController: CLLocationManagerDelegate {
    
    //обработка доступа к геолокации
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse: //разрешено при использовании приложения и в фоновом режиме/ при использовании приложения
            manager .requestLocation()//сам запрос геолокации. после него вызывается метод locationManager
        case .denied, .restricted:  //запрещено пользователеем / запрещено удаленно, например родительский контроль, корпоративный контроль
            SharedAlert.shared.showAlert(alertTitle: "Внимарие!", alertMessage: "Определение геолокации невозможно или запрещено пользоватилем. Проверьте настройки")
        case .notDetermined: //пользователь еще не осуществил выбор способа определения геолокации
            SharedAlert.shared.showAlert(alertTitle: "Внимание!", alertMessage: "Определение геолокации не запрошено. Выберите и разрешите в настройках подходящий  способ определения геолокации")
        @unknown default:
            fatalError()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.setCenter(
                location.coordinate,
                animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DismissAlert.shared.dismissAlert(viewController: self,
                                         titles: "Warning",
                                         message: "Failed to get user's location")
    }
}
