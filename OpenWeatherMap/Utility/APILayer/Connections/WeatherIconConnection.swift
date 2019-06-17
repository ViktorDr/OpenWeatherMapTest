//
//  WeatherIconConnection.swift
//  OpenWeatherMap
//
//  Created by admin on 6/17/19.
//  Copyright © 2019 Viktor Drykin. All rights reserved.
//

import Foundation

struct WeatherIconConnection {
    
    static func iconPath(endPoint: String, name: String) -> String {
        return endPoint + "img/w/" + name
    }
}
