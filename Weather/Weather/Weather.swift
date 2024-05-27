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
    
    func setWeatherType() {
        do {
            let fetchWeatherString = try YumemiWeather.fetchWeatherCondition(at: "")
            self.delegate?.setWeatherType(type: fetchWeatherString)
        } catch {
            self.delegate?.handleError(alert: "エラー　a1234")
        }
    }
}
