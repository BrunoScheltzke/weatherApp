//
//  MapViewPresenter.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 16/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import Foundation
import MapKit

protocol MapViewPresenterProtocol {
    
    func presentGenericError()
    func presentMessageForNotFindingLocation()
    func presentUserCoordinate(_ coordinate: CLLocationCoordinate2D, on region: MKCoordinateRegion)
    
}

class MapViewPresenter: MapViewPresenterProtocol {
    
    let view: MapViewProtocol
    
    init(view: MapViewProtocol) {
        self.view = view
    }
    
    func presentUserCoordinate(_ coordinate: CLLocationCoordinate2D, on region: MKCoordinateRegion) {
        view.displayUserCoordinate(coordinate, on: region)
    }
    
    func presentGenericError() {
        view.displayError("We are having some issues. Try again later.")
    }
    
    func presentMessageForNotFindingLocation() {
        view.displayError("We are having problems finding your location.")
    }
    
}
