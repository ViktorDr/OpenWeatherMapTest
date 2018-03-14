//
//  ParametersMapper.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation

class ParametersMapper {
    
    private let cityKey = "id"
    private let appIDKey = "APPID"
    
    func cityWeather(cityId city : Int, apiKey : String) -> Dictionary<String, Any> {
        return [cityKey : city, appIDKey : apiKey];
    }
}
