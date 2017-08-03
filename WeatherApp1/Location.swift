//
//  Location.swift
//  WeatherApp1
//
//  Created by Aditya Gunda on 8/3/17.
//  Copyright © 2017 Aditya Gunda. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    //singleton class - creates a static instance within the class and makes the init private, so no other instances can be made 
    static var sharedInstance  = Location()
    private init() {}
    
    var long: Double!
    var lat: Double!
}
