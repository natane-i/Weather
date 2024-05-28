//
//  Weather.swift
//  Weather
//
//  Created by spark-01 on 2024/05/24.
//

import Foundation
import YumemiWeather

struct Date: Codable {
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

protocol WeatherDelegate {
    func setWeather(weather: Weather)
    func setWeatherError(alert: String)
}

class WeatherDetail {
    var delegate: WeatherDelegate?
    
    func setWeatherType() {
        
        let sendJsonString = Date(area: "Tokyo", date: "2020-04-01T12:00:00+09:00")
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(sendJsonString)
            guard let requestJson = String(data: jsonData, encoding: .utf8) else {
                return
            }
            
            let fetchWeatherString = try YumemiWeather.fetchWeather(requestJson)
            guard let jsonData = fetchWeatherString.data(using: .utf8) else {
                return
            }
            
            let decoder = JSONDecoder()
            let weather = try decoder.decode(Weather.self, from: jsonData)
            
            self.delegate?.setWeather(weather: weather)
        } catch {
            self.delegate?.setWeatherError(alert: "エラー　a1234")
        }
    }
}

