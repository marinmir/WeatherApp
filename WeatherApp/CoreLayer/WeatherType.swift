//
//  WeatherType.swift
//  WeatherApp
//
//  Created by Мирошниченко Марина on 17.09.2021.
//

import Foundation

enum WeatherType {
    case rainy
    case sunny
    case snowy
    case windy
    case cloudy
    case unknown
    
    init(description: String) {
        if description.contains("rain") {
            self = .rainy
        } else if description.contains("sun") {
            self = .sunny
        } else if description.contains("snow") {
            self = .snowy
        } else if description.contains("wind") {
            self = .windy
        } else if description.contains("cloud") {
            self = .cloudy
        } else {
            self = .unknown
        }
    }
}
