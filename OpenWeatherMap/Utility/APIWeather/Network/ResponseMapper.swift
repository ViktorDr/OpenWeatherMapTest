//
//  ResponseMapper.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseMapper {
    
    func cityWeatherResponseMapping(_ response : Any ) throws -> Any {
        guard let responseDict = response as? [String : Any] else {
            return false
        }
        if let cityWeather = Mapper<CityWeather>().map(JSON: responseDict) {
            return cityWeather
        } else {
            return false
        }
    }
    
}
