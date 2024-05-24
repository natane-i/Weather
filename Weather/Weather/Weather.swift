//
//  Weather.swift
//  Weather
//
//  Created by spark-01 on 2024/05/24.
//

import Foundation
import YumemiWeather

protocol YumemiDelegate {
    func setWeatherImage(type: String)
}

class WeatherDetail {
    var delegate: YumemiDelegate?
    
    func setWeatherImage() -> String {
        let fetchWeatherString = YumemiWeather.fetchWeatherCondition()
        return fetchWeatherString
    }
}
