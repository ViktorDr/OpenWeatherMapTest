//
//  CityManager.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import ObjectMapper

protocol FileManagerProtocol {
    func cities(completion : @escaping ([City]) -> Void)
}

class FileManager : FileManagerProtocol {
    private let cityFile = "city.list"
    private let fileType = "json"
    
    func cities(completion : @escaping ([City]) -> Void) {
        
        guard let file = Bundle.main.url(forResource: cityFile, withExtension: fileType) else {
            completion([City]())
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: []) as!  [[String : Any]]
                let cities = Mapper<City>().mapArray(JSONArray: json)
                DispatchQueue.main.async { completion(cities) }
            } catch {
                DispatchQueue.main.async { completion([City]()) }
            }
        }
    }
}
