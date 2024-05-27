//
//  Weather.swift
//  Weather
//
//  Created by spark-01 on 2024/05/24.
//

import Foundation
import YumemiWeather

protocol YumemiDelegate {
    func setWeatherType(type: String)
    func handleError(alert: String)
}

class WeatherDetail {
    var delegate: YumemiDelegate?
    
    let requestJson = """
        {
            "area": "Tokyo",
            "date": "2020-04-01T12:00:00+09:00"
        }
    """
    
    func setWeatherType() {
        do {
            let fetchWeatherString = try YumemiWeather.fetchWeather(requestJson)
            print(fetchWeatherString)
            self.delegate?.setWeatherType(type: fetchWeatherString)
        } catch {
            self.delegate?.handleError(alert: "エラー　a1234")
        }
    }
}


