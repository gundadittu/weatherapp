//
//  WeatherCell.swift
//  WeatherApp1
//
//  Created by Aditya Gunda on 8/2/17.
//  Copyright © 2017 Aditya Gunda. All rights reserved.
//

import Foundation

class Forecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highT: String!
    private var _lowT: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highT: String {
        if _highT == nil {
            _highT = ""
        }
        return _highT
    }
    
    var lowT: String {
        if _lowT == nil {
            _lowT = ""
        }
        return _lowT
    }
    
    init(weatherDict: Dictionary<String,AnyObject>){
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
                let preKelvinToFarenheit = (min * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * preKelvinToFarenheit/10))
                 self._lowT = "\(kelvinToFarenheit)"
            }
            if let max = temp["max"] as? Double {
                let preKelvinToFarenheit = (max * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * preKelvinToFarenheit/10))
                self._highT = "\(kelvinToFarenheit)"
            }
        }
        if let date = weatherDict["dt"] as? Double {
                let unixConvertedDate = Date(timeIntervalSince1970: date)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full
                dateFormatter.dateFormat = "EEEE"
                dateFormatter.timeStyle = .none
                self._date = unixConvertedDate.dayOfTheWeek()
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let type = weather[0]["main"] as? String{
                self._weatherType = type
            }
        }
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
