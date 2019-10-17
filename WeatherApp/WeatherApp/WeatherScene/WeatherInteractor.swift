//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 16/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import Foundation

protocol WeatherInteractorProtocol {
    
    func getWeatherDetails()
    
}

class WeatherInteractor: WeatherInteractorProtocol {
    
    let presenter: WeatherPresenterProtocol
    let weatherModel: WeatherModel
    
    init(presenter: WeatherPresenterProtocol, weatherModel: WeatherModel) {
        self.presenter = presenter
        self.weatherModel = weatherModel
    }
    
    func getWeatherDetails() {
        presenter.presentWeather(weatherModel: weatherModel)
    }
    
}
