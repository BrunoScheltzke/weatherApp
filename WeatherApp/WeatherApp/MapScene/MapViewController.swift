//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 16/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewProtocol {
    
    func displayError(_ error: String)
    func displayUserCoordinate(_ coordinate: CLLocationCoordinate2D, on region: MKCoordinateRegion)
    
}

class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    let mapView = MKMapView()
    var interactor: MapViewInteractorProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMapView()
        addsTapGestureToMapView()
        interactor?.getUserLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - View setup
    
    func addMapView() {
        mapView.delegate = self

        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        view.addConstraints(constraints)
    }
    
    func addsTapGestureToMapView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(requestWeatherForLocation))
        tap.numberOfTapsRequired = 2
        mapView.subviews[0].addGestureRecognizer(tap)
    }
    
    @objc func requestWeatherForLocation(gestureReconizer: UILongPressGestureRecognizer) {
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.annotations.forEach { mapView.removeAnnotation($0) }
        mapView.addAnnotation(annotation)
        
        interactor?.getWeather(for: coordinate)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    
}

extension MapViewController: MapViewProtocol {
    
    func displayError(_ error: String) {
        // present alert with error
    }
    
    func displayUserCoordinate(_ coordinate: CLLocationCoordinate2D, on region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
}
