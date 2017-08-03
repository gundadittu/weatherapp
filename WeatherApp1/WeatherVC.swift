//
//  ViewController.swift
//  WeatherApp1
//
//  Created by Aditya Gunda on 8/2/17.
//  Copyright © 2017 Aditya Gunda. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentTempDesc: UILabel!
    @IBOutlet weak var currentTempImage: UIImageView!
    
    let cw = CurrentWeather()
    var forecasts = [Forecast]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.long = currentLocation.coordinate.longitude
            Location.sharedInstance.lat = currentLocation.coordinate.latitude
            //print(Location.sharedInstance.long)
            //print(Location.sharedInstance.lat)
            cw.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            cell.configureCell(forecasts[indexPath.row])
            return cell
        }
        return WeatherCell() 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func updateMainUI(){
        currentDateLabel.text = cw.date
        currentTempLabel.text = "\(cw.currentTemp)"
        currentLocationLabel.text = cw.cityName
        currentTempDesc.text = cw.weatherType
        currentTempImage.image = UIImage(named: cw.weatherType)
        
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for each in list {
                        let forecast = Forecast(weatherDict: each)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }

}

