//
//  Weather.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import ObjectMapper

struct CityWeather : Mappable {
    var coordinate : Coordinate?
    var weather : [Weather]?
    var mainInfo : WeatherMainInformation?
    var base : String?
    var date : Date?
    var id : Int?
    var name : String?
    var visibility : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        coordinate <- map["coord"]
        weather <- map["weather"]
        mainInfo <- map["main"]
        visibility <- map["visibility"]
        base <- map["base"]
        date <- (map["dt"], DateTransform())
        id <- map["id"]
        name <- map["name"]
    }
    
}

struct WeatherMainInformation : Mappable {
    var temperature : Double?
    var pressure : Int?
    var humidity : Int?
    var minimalTemperature : Double?
    var maximumTemperature : Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        temperature <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        minimalTemperature <- map["temp_min"]
        maximumTemperature <- map["temp_max"]
    }
    
}
struct Weather : Mappable {
    
    var id : Int?
    var main : String?
    var description : String?
    var icon : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
    
}
