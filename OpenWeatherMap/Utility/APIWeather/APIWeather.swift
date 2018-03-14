//
//  APIWeather.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation

class APIWeather {
    
    static let shared = APIWeather()
    private var networkEngine : NetworkEngineProtocol
    private let fileEngine : FileManagerProtocol
    
    private init() {
        fileEngine = FileManager()
        
        let urlMapper = UrlMapper()
        let parametersMapper = ParametersMapper()
        let responseMapper = ResponseMapper()
        let coreNetwork = NetworkCoreEngine()
        let configuration = NetworkConfiguration()
        networkEngine = NetworkEngine(urlMapper: urlMapper, paramsMapper: parametersMapper, responseMapper: responseMapper, configuration: configuration, taskPerformer: coreNetwork)
    }
    
    func cityWeather(cityId city : Int, completion : @escaping (Bool, Any) -> Void) {
        networkEngine.cityWeather(cityId: city) { (success, result) in
            completion(success, result)
        }
    }
    
    func imageIcon(_ name : String) -> String {
        return networkEngine.imageIcon(name)
    }
    
    func cities(_ completion : @escaping (Any) -> Void) {
        fileEngine.cities { (cities) in
            completion(cities)
        }
    }
    
}
