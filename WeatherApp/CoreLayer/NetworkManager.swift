//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Мирошниченко Марина on 09.08.2021.
//

import Foundation

protocol NetworkManager {
    func fetchCurrentLocationWeather(lat: String,
                                     lon: String,
                                     completion: @escaping (WeatherModel) -> ())
    func fetchCurrentWeather(city: String,
                             completion: @escaping (WeatherModel) -> ())
}

class NetworkManagerImpl: NetworkManager {
    
    // MARK: - Private properties
    
    private static let apiKey = "fb2dd5aca8fbf5bdfec52cb749da3bcc"
    private let session = URLSession(configuration: .default)
    private var task: URLSessionDataTask?
    
    // MARK: - Public methods
    
    func fetchCurrentWeather(city: String, completion: @escaping (WeatherModel) -> ()) {
        if var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather") {
            urlComponents.query = "q=\(city)&appid=\(NetworkManagerImpl.apiKey)&units=metric"
            guard let url = urlComponents.url else {
                return
            }
            
            loadWeather(url: url, completion: completion)
        }
    }
    
    func fetchCurrentLocationWeather(lat: String, lon: String, completion: @escaping (WeatherModel) -> ()) {
        if var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather") {
            urlComponents.query = "lat=\(lat)&lon=\(lon)&appid=\(NetworkManagerImpl.apiKey)&units=metric"
            guard let url = urlComponents.url else {
                return
            }
            
            loadWeather(url: url, completion: completion)
        }
    }
    
    // MARK: - Private methods
    
    private func loadWeather(url: URL, completion: @escaping (WeatherModel) -> ()) {
        task = session.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.task = nil
            }
            
            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                
                guard let currentWeather = try? JSONDecoder().decode(WeatherModel.self, from: data) else {
                    return
                }
                completion(currentWeather)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task?.resume()
    }
}
