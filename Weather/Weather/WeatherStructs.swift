//
//  WeatherStructs.swift
//  Weather
//
//  Created by spark-01 on 2024/05/29.
//

import Foundation
import YumemiWeather

struct SetDate: Codable {
    let area: String
    let date: String
}

struct Weather: Codable {
    let maxTemp: Int
    let minTemp: Int
    let weatherCondition: String
    
    enum CodingKeys: String, CodingKey {
        case maxTemp = "max_temperature"
        case minTemp = "min_temperature"
        case weatherCondition = "weather_condition"
    }
}

struct Dates: Codable {
    let areas: [String]
    let date: String
}

struct Weathers: Codable {
    let area: Area
    let info: Weather
}
