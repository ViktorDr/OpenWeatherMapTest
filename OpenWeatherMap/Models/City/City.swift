//
//  City.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import ObjectMapper

struct City : Mappable {
    var id : Int?
    var name : String?
    var country : String?
    var coordinate : Coordinate?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        country <- map["country"]
        coordinate <- map["coord"]
    }
    
}
