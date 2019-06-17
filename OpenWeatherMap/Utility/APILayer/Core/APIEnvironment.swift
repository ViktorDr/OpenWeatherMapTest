//
//  APIEnvironment.swift
//  OpenWeatherMap
//
//  Created by admin on 6/17/19.
//  Copyright © 2019 Viktor Drykin. All rights reserved.
//

import Foundation

struct APIEnvironment {
    static let appIdKey = "af12d0aeb60b68ca7bcbbb77daf147b4"
    static var endPoint = "http://api.openweathermap.org/"
    
    static func configureUrlPath(with path: String) -> String {
        return endPoint + path
    }
    
    static func addAppIdKey(parameters: inout Parameters?) {
        parameters?["APPID"] = appIdKey
    }    
}
