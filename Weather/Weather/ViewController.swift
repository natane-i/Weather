//
//  ViewController.swift
//  Weather
//
//  Created by spark-01 on 2024/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnReload(_ sender: Any) {
        setWeatherType()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    let weatherDetail = WeatherDetail()
    
    func setWeatherType() {
        var weatherName = "sunny"
        var tintColor = UIColor.red
        
        let weatherType = weatherDetail.setWeatherImage()
        
        switch weatherType {
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

