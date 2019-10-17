//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 16/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import UIKit

protocol WeatherViewProtocol {
    
    func display(weatherModel: WeatherModel)
    
}

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    var interactor: WeatherInteractorProtocol?
    
    init() {
        super.init(nibName: "WeatherViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getWeatherDetails()
    }
    
}

extension WeatherViewController: WeatherViewProtocol {
    
    func display(weatherModel: WeatherModel) {
        cityLabel.text = weatherModel.city
        countryLabel.text = weatherModel.country
        temperatureLabel.text = "\(weatherModel.temperature)"
        pressureLabel.text = "\(weatherModel.pressure)"
        humidityLabel.text = "\(weatherModel.humidity)"
        minTemperatureLabel.text = "\(weatherModel.tempMin)"
        maxTemperatureLabel.text = "\(weatherModel.tempMax)"
    }
    
}
