//
//  APIEngine.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation

protocol NetworkEngineProtocol {
    func cityWeather(cityId city : Int, completion : @escaping (Bool, Any) -> Void)
    func imageIcon(_ name : String) -> String
}

class NetworkEngine : NetworkEngineProtocol {
    
    private let urlMapper : UrlMapper
    private let paramsMapper : ParametersMapper
    private let responseMapper : ResponseMapper
    private let configuration : NetworkConfiguration
    private let taskPerformer : NetworkCoreEngine
    
    init(urlMapper : UrlMapper, paramsMapper : ParametersMapper, responseMapper : ResponseMapper, configuration : NetworkConfiguration, taskPerformer : NetworkCoreEngine) {
        self.urlMapper = urlMapper
        self.paramsMapper = paramsMapper
        self.responseMapper = responseMapper
        self.configuration = configuration
        self.taskPerformer = taskPerformer
    }
    
    func cityWeather(cityId city : Int, completion : @escaping (Bool, Any) -> Void) {
        let url = urlMapper.cityWeatherUrl
        let params = paramsMapper.cityWeather(cityId: city, apiKey: configuration.APIKey)
        let responseHandler = responseMapper.cityWeatherResponseMapping
        taskPerformer.performRequest(url, parameters: params, requestMethod: .get, handleResponse: responseHandler) { (success, result) in
            completion(success, result)
        }
    }
    
    func imageIcon(_ name : String) -> String {
        return urlMapper.imageIconAddress(name)
    }
    
}
