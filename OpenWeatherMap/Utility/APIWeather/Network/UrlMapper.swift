//
//  UrlMapper.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation

class UrlMapper {
    
    private let accessPoint = "http://api.openweathermap.org/"
    
    var cityWeatherUrl : String {
        return accessPoint + "data/2.5/weather"
    }
    
    func imageIconAddress(_ name : String) -> String {
        return accessPoint + "img/w/" + name
    }
    

}
