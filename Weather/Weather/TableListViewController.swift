//
//  TableListViewController.swift
//  Weather
//
//  Created by spark-01 on 2024/06/03.
//

import UIKit

class TableListViewController: UIViewController, UITableViewDataSource {
    
    let weatherList = WeatherList()
    var weatherData: [Weathers] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        fetchWeatherData()
    }
    
    @objc func reloadData(_ sender: Any) {
        fetchWeatherData()
        tableView.refreshControl?.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let weather = weatherData[indexPath.row]
        
        var weatherName = "sunny"
        var tintColor = UIColor.red
        
        switch weather.info.weatherCondition{
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
        
        cell.textLabel?.text = weather.area.rawValue
        cell.imageView?.image = UIImage(named: weatherName)
        cell.imageView?.tintColor = tintColor
        cell.detailTextLabel?.text = "最高気温：\(weather.info.maxTemp)℃　最低気温：\(weather.info.minTemp)℃"
        return cell
    }
    
    func fetchWeatherData() {
        self.weatherList.setWeatherType { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weathers):
                    print(weathers)
                    self.weatherData = weathers
                    self.tableView.reloadData()
                case .failure(let error):
                    self.setWeatherError(alert: "Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func setWeatherError(alert: String) {
        DispatchQueue.main.async {
            let alertMessage = UIAlertController(title: "\(alert)", message: "時間をおいて再度お試しください", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.fetchWeatherData()
            })
            alertMessage.addAction(okAction)
            self.present(alertMessage, animated: true, completion: nil)
        }
        fetchWeatherData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! ViewController
                let data = weatherData[indexPath.row]
                detailVC.weatherInfo = data.info
            }
        }
    }
    
    
}
