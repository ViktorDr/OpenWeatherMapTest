//
//  Weather.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation

struct CityWeather: Codable {
    
    var coordinate: Coordinate?
    var weather: [Weather]?
    var mainInfo: WeatherMainInformation?
    var base: String?
    var date: Date?
    var id: Int?
    var name: String?
    var visibility: Int?
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        case weather
        case mainInfo = "main"
        case base
        case date = "dt"
        case id
        case name
        case visibility
    }
}

struct WeatherMainInformation: Codable {
    var temperature: Double?
    var pressure: Double?
    var humidity: Int?
    var minimalTemperature: Double?
    var maximumTemperature: Double?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure
        case humidity
        case minimalTemperature = "temp_min"
        case maximumTemperature = "temp_max"
    }
}

struct Weather: Codable {
    
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}
