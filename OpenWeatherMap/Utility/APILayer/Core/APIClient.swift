//
//  APIClient.swift
//  OpenWeatherMap
//
//  Created by admin on 6/16/19.
//  Copyright © 2019 Viktor Drykin. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    static let shared = APIClient()
    
    func start<C: Connection>(connection: C, successHandler: @escaping ((C.ReturnType) -> Void), failureHandler: @escaping ((_ error: Error) -> Void)) {
        let url = APIEnvironment.configureUrlPath(with: connection.path)
        
        var parameters = connection.parameters
        if connection.isNeededApiKey {
            APIEnvironment.addAppIdKey(parameters: &parameters)
        }
        
        Alamofire.request(url, method: connection.method, parameters: parameters, headers: connection.headers).response { response in
            if let error = response.error {
                failureHandler(error)
                return
            }
            if let data = response.data {
                do {
                    let result = try connection.parse(data: data)
                    successHandler(result)
                } catch let error {
                    failureHandler(error)
                }
            }
        }
    }
    
    func imageIconPath(by name: String) -> String {
        return WeatherIconConnection.iconPath(endPoint: APIEnvironment.endPoint, name: name)
    }
}
