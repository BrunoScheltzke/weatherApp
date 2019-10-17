//
//  Router.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 16/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import UIKit

class Router {
    
    private static var navigationController: UINavigationController?
    
    static func showInitialScene(on navigationController: UINavigationController) {
        self.navigationController = navigationController
        showMapScene()
    }
    
    static func showMapScene() {
        let mapVC = MapViewController()
        let presenter = MapViewPresenter(view: mapVC)
        let interactor = MapViewInteractor(presenter: presenter, repository: WeatherRepository())
        mapVC.interactor = interactor
        
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    static func showWeatherScene(with weatherModel: WeatherModel) {
        let weatherVC = WeatherViewController()
        let presenter = WeatherPresenter(view: weatherVC)
        let interactor = WeatherInteractor(presenter: presenter, weatherModel: weatherModel)
        weatherVC.interactor = interactor
        
        navigationController?.pushViewController(weatherVC, animated: true)
    }
    
}
