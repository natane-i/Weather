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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherDetail.delegate = self
    }
    
    @IBAction func btnReload(_ sender: Any) {
        weatherDetail.setWeatherType()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension ViewController: WeatherDelegate {
    
    func setWeatherType(type: String) {
        var weatherName = "sunny"
        var tintColor = UIColor.red
        
        switch type {
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
        
        weatherImageView.image = UIImage(named: weatherName)
        weatherImageView.tintColor = tintColor
    }
    
    func setWeatherMaxTemp(type: Int) {
        maxTempLabel.text = "\(type)℃"
    }
    
    func setWeatherMinTemp(type: Int) {
        minTempLabel.text = "\(type)℃"
    }
    
    func setWeatherError(alert: String) {
        let alertMessage = UIAlertController(title: "\(alert)", message: "時間をおいて再度お試しください", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertMessage.addAction(okAction)
        present(alertMessage, animated: true, completion: nil)
    }
    
}


