//
//  CityWeatherConnection.swift
//  OpenWeatherMap
//
//  Created by admin on 6/17/19.
//  Copyright © 2019 Viktor Drykin. All rights reserved.
//

import Foundation
import Alamofire

struct CityWeatherConnection: Connection {
    
    typealias ReturnType = CityWeather
    
    let cityId: Int
    
    init(cityId: Int) {
        self.cityId = cityId
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "data/2.5/weather"
    }
    
    var parameters: Parameters? {
        return ["id": cityId]
    }
    
    var isNeededApiKey: Bool {
        return true
    }
    
    var httpBody: Data?
    
    var headers: Headers?
    
    func parse(data: Data) throws -> CityWeather {
        do {
            let cityWeather = try JSONDecoder.dateSince1970.decode(CityWeather.self, from: data)
            return cityWeather
        }
    }
}
