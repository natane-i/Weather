//
//  ViewController.swift
//  Weather
//
//  Created by spark-01 on 2024/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    let weatherDetail = WeatherDetail()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherDetail.delegate = self
        indicator.isHidden = true
    }
    
    @IBAction func btnReload(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        weatherDetail.setWeatherType()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension ViewController: WeatherDelegate {
    
    func setWeather(weather: Weather) {
        var weatherName = "sunny"
        var tintColor = UIColor.red
        
        switch weather.weatherCondition{
        case "sunny":
            weatherName = "sunny"
            tintColor = UIColor.red
        case "cloudy":
            weatherName = "cloudy"
            tintColor = UIColor.gray
        case "rainy":
            weatherName = "rainy"
            tintColor = UIColor.blue
        default:
            break
        }
        
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            
            self.weatherImageView.image = UIImage(named: weatherName)
            self.weatherImageView.tintColor = tintColor
            
            self.maxTempLabel.text = String("\(weather.maxTemp)℃")
            self.minTempLabel.text = String("\(weather.minTemp)℃")
        }
    }
    
    func setWeatherError(alert: String) {
        let alertMessage = UIAlertController(title: "\(alert)", message: "時間をおいて再度お試しください", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertMessage.addAction(okAction)
        
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.present(alertMessage, animated: true, completion: nil)
        }
    }
}


