//
//  ViewController.swift
//  Weather
//
//  Created by spark-01 on 2024/05/22.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func btnReload(_ sender: Any) {
        setWeatherType()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func setWeatherType() {
        let fetchWeatherString = YumemiWeather.fetchWeatherCondition()
        
        var weatherName = "sunny"
        var tintColor = UIColor.red
        
        switch fetchWeatherString {
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

}

