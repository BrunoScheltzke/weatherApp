//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 16/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    
    var temperature: Double
    var pressure: Double
    var humidity: Double
    var tempMin: Double
    var tempMax: Double
    var country: String
    var city: String
    
    enum CodingKeys: String, CodingKey {
        case temperatureContainer = "main"
        case countryContainer = "sys"
        case cityName = "name"
    }
    
    enum TemperatureInfo: String, CodingKey {
        case temp
        case pressure
        case humidity
        case temp_min
        case temp_max
    }
    
    enum CountryInfo: String, CodingKey {
        case country
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let temperatureInfo = try values.nestedContainer(keyedBy: TemperatureInfo.self, forKey: .temperatureContainer)
        let countryInfo = try values.nestedContainer(keyedBy: CountryInfo.self, forKey: .countryContainer)
        
        temperature = try temperatureInfo.decode(Double.self, forKey: .temp)
        pressure = try temperatureInfo.decode(Double.self, forKey: .pressure)
        humidity = try temperatureInfo.decode(Double.self, forKey: .humidity)
        tempMin = try temperatureInfo.decode(Double.self, forKey: .temp_min)
        tempMax = try temperatureInfo.decode(Double.self, forKey: .temp_max)
        country = try countryInfo.decode(String.self, forKey: .country)
        city = try values.decode(String.self, forKey: .cityName)
    }
    
}
