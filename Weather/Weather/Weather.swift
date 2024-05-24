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
}

class WeatherDetail {
    var delegate: YumemiDelegate?
    
    func setWeatherType() {
        let fetchWeatherString = YumemiWeather.fetchWeatherCondition()
        delegate?.setWeatherType(type: fetchWeatherString)
    }
}
