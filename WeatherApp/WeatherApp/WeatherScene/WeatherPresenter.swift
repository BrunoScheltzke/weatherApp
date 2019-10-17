//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 16/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import Foundation

protocol WeatherPresenterProtocol {
    
    func presentWeather(weatherModel: WeatherModel)
    
}

class WeatherPresenter: WeatherPresenterProtocol {
    
    let view: WeatherViewProtocol
    
    init(view: WeatherViewProtocol) {
        self.view = view
    }
    
    func presentWeather(weatherModel: WeatherModel) {
        view.display(weatherModel: weatherModel)
    }
    
}
