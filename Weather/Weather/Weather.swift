//
//  Weather.swift
//  Weather
//
//  Created by spark-01 on 2024/05/24.
//

import Foundation
import YumemiWeather

protocol WeatherDelegate {
    func setWeather(weather: Weather)
    func setWeatherError(alert: String)
}

class WeatherDetail {
    var delegate: WeatherDelegate?
    
    func setWeatherType() {
        DispatchQueue.global().async {
            let sendJsonString = Date(area: "Tokyo", date: "2020-04-01T12:00:00+09:00")
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(sendJsonString)
                guard let requestJson = String(data: jsonData, encoding: .utf8) else {
                    return
                }
                
                let fetchWeatherString = try YumemiWeather.syncFetchWeather(requestJson)
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
}

