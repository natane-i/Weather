//
//  Weather.swift
//  Weather
//
//  Created by spark-01 on 2024/05/24.
//

import Foundation
import YumemiWeather

protocol WeatherDelegate {
    func setWeatherType(type: Any)
    func setWeatherError(alert: String)
}

class WeatherDetail {
    var delegate: WeatherDelegate?
    
    let requestJson = """
        {
            "area": "Tokyo",
            "date": "2020-04-01T12:00:00+09:00"
        }
    """
    
    func setWeatherType() {
        do {
            let fetchWeatherString = try YumemiWeather.fetchWeather(requestJson)
            guard let jsonData = fetchWeatherString.data(using: .utf8),
                  let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                  let maxTemp = jsonObject["max_temperature"] as? Int,
                  let minTemp = jsonObject["min_temperature"] as? Int,
                  let weather = jsonObject["weather_condition"] as? String else {
                return
            }
            
            self.delegate?.setWeatherType(type: maxTemp)
            self.delegate?.setWeatherType(type: minTemp)
            self.delegate?.setWeatherType(type: weather)
        } catch {
            self.delegate?.setWeatherError(alert: "エラー　a1234")
        }
    }
}

