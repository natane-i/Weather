//
//  CollectionListViewController.swift
//  Weather
//
//  Created by spark-01 on 2024/06/06.
//

import UIKit
import YumemiWeather

class CollectionListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let weatherList = WeatherList()
    var weatherData: [Weathers] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        reloadWeather()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshWeather(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func refreshWeather(_ sender: Any) {
        reloadWeather()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let weather = weatherData[indexPath.row]
        let areaName = weather.area.rawValue
        
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
        
        cell.areaName?.text = areaName
        
        cell.imageView?.image = UIImage(named: weatherName)
        cell.imageView?.tintColor = tintColor
        
        return cell
    }
    
    func reloadWeather() {
        self.weatherList.setWeatherList { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let weathers):
                    strongSelf.weatherData = weathers
                    strongSelf.collectionView.reloadData()
                case .failure(let error):
                    strongSelf.setWeatherError(alert: "Error: \(error.localizedDescription)")
                }
                strongSelf.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    func setWeatherError(alert: String) {
        DispatchQueue.main.async {
            let alertMessage = UIAlertController(title: "\(alert)", message: "時間をおいて再度お試しください", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                self?.reloadWeather()
            })
            alertMessage.addAction(okAction)
            self.present(alertMessage, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first, let detailVC = segue.destination as? ViewController {
                detailVC.weatherInfo = weatherData[indexPath.row]
            }
        }
    }
    
}

extension CollectionListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = CGFloat(screenWidth / 4.0)
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 9.0 // 行間のスペース
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 0.0 // 列間のスペース
     }

}
