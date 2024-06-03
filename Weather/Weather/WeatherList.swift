//
//  WeatherList.swift
//  Weather
//
//  Created by spark-01 on 2024/06/03.
//

import Foundation
import YumemiWeather

class WeatherList {
    func setWeatherType(completion: @escaping (Result<[Weathers], Error>) -> Void) {
        DispatchQueue.global().async {
            let sendJsonString = Dates(areas: [], date: "2020-04-01T12:00:00+09:00")
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(sendJsonString)
                guard let requestJson = String(data: jsonData, encoding: .utf8) else {
                    return
                }
                
                let fetchWeatherString = try YumemiWeather.syncFetchWeatherList(requestJson)
                
                guard let jsonData = fetchWeatherString.data(using: .utf8) else {
                    return
                }
                
                let decoder = JSONDecoder()
                let weathers = try decoder.decode([Weathers].self, from: jsonData)
                
                completion(.success(weathers))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
