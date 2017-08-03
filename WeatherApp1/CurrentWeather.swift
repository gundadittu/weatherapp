//
//  CurrentWeather.swift
//  WeatherApp1
//
//  Created by Aditya Gunda on 8/2/17.
//  Copyright © 2017 Aditya Gunda. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, " + currentDate
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        let cwURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(cwURL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }

                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let wt = weather[0]["main"] as? String {
                        self._weatherType = wt
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        let preKelvinToFarenheit = (currentTemperature * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * preKelvinToFarenheit/10))
                        self._currentTemp = kelvinToFarenheit
                    }
                }
            }
            completed()
        }
    }
}
