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
