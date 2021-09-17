//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Мирошниченко Марина on 24.08.2021.
//

import Foundation

struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    let dt: Int
    lazy var weatherType = WeatherType(description: weather[0].description)
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
}
