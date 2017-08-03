//
//  WeatherCell.swift
//  WeatherApp1
//
//  Created by Aditya Gunda on 8/3/17.
//  Copyright © 2017 Aditya Gunda. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

        @IBOutlet weak var weatherIcon: UIImageView!
        @IBOutlet weak var lowTempLabel: UILabel!
        @IBOutlet weak var highTempLabel: UILabel!
        @IBOutlet weak var weatherType: UILabel!
        @IBOutlet weak var dayLabel: UILabel!
        
        func configureCell(_ forecast: Forecast){
            lowTempLabel.text = "\(forecast.lowT)"
            highTempLabel.text = "\(forecast.highT)"
            weatherType.text = forecast.weatherType
            dayLabel.text = forecast.date
            weatherIcon.image = UIImage(named: forecast.weatherType) 
        }

}
