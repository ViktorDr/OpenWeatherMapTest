//
//  Coordinate.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import ObjectMapper

struct Coordinate : Mappable  {
    var longitude : Double?
    var latitude : Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        longitude <- map["lon"]
        latitude <- map["lat"]
    }
}
