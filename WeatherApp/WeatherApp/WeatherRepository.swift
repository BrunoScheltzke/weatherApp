//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Bruno Scheltzke on 16/10/19.
//  Copyright © 2019 Bruno Scheltzke. All rights reserved.
//

import Foundation

protocol WeatherRepositoryProtocol {
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping(Result<WeatherModel, Error>) -> Void)
    
}

private let basePath: String = "https://api.openweathermap.org/data/2.5/"

class WeatherRepository: WeatherRepositoryProtocol {
    
    private let session: URLSession
    
    private let weatherPath: String = basePath + "weather"
    
    private let appIDKey = "&appid=6861cf4649a08e763792df8ac0d4d266"
    private let latitudeKey = "lat"
    private let longitudeKey = "lon"
    
    init(_ session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping(Result<WeatherModel, Error>) -> Void) {
        
        let path = "\(weatherPath)?\(latitudeKey)=\(latitude)&\(longitudeKey)=\(longitude)\(appIDKey)"
        
        guard let url = URL(string: path) else {
            completion(.failure(CustomError.internetConnection))
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(CustomError.internetConnection))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
}

enum CustomError: Error {
    
    case internetConnection
    
}
