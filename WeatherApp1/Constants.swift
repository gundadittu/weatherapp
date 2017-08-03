//
//  Constants.swift
//  WeatherApp1
//
//  Created by Aditya Gunda on 8/2/17.
//  Copyright © 2017 Aditya Gunda. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let long = Location.sharedInstance.long!
let lat = Location.sharedInstance.lat!

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=e6247bff86e900bd65b7d754fd0deba0"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(lat)&lon=\(long)&cnt=8&appid=e6247bff86e900bd65b7d754fd0deba0"
