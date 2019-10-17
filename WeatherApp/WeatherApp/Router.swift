//
//  Router.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 16/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import UIKit

class Router {
    
    static func showMapScene(on navigationController: UINavigationController) {
        let mapVC = MapViewController()
        let presenter = MapViewPresenter(view: mapVC)
        let interactor = MapViewInteractor(presenter: presenter, repository: WeatherRepository())
        mapVC.interactor = interactor
        
        navigationController.pushViewController(mapVC, animated: true)
    }
    
}
