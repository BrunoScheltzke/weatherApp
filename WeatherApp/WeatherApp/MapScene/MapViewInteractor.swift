//
//  MapViewInteractor.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 16/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol MapViewInteractorProtocol {
    
    func getUserLocation()
    func getWeather(for coordinate: CLLocationCoordinate2D)
    
}

class MapViewInteractor: NSObject, MapViewInteractorProtocol {
    
    private let locationManager = CLLocationManager()
    let presenter: MapViewPresenterProtocol
    let repository: WeatherRepositoryProtocol
    
    init(presenter: MapViewPresenterProtocol, repository: WeatherRepositoryProtocol) {
        self.presenter = presenter
        self.repository = repository
    }
    
    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func getWeather(for coordinate: CLLocationCoordinate2D) {
        repository.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    Router.showWeatherScene(with: weather)
                case .failure(_):
                    self.presenter.presentGenericError()
                }
            }
        }
    }
    
    func getUserWeather(with coordinate: CLLocationCoordinate2D) {
        repository.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.presenter.presentUserWeather(weatherModel: weather)
                case .failure(_):
                    break
                }
            }
        }
    }
    
}

extension MapViewInteractor: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            presenter.presentUserCoordinate(center, on: region)
            getUserWeather(with: center)
        } else {
            presenter.presentMessageForNotFindingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presenter.presentMessageForNotFindingLocation()
    }
    
}
