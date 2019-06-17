//
//  City.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation

struct City: Codable {
    var id : Int?
    var name : String?
    var country : String?
    var coordinate : Coordinate?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case coordinate = "coord"
    }
}
