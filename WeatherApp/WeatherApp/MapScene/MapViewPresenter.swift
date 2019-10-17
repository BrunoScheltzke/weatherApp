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
    
    func presentError(_ error: String)
    func presentUserCoordinate(_ region: MKCoordinateRegion)
    
}

class MapViewPresenter: MapViewPresenterProtocol {
    
    let view: MapViewProtocol
    
    init(view: MapViewProtocol) {
        self.view = view
    }
    
    func presentError(_ error: String) {
        view.displayError(error)
    }
    
    func presentUserCoordinate(_ region: MKCoordinateRegion) {
        view.displayUserCoordinate(region)
    }
    
}
