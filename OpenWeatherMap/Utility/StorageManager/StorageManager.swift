//
//  CityManager.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation

struct StorageManager {
    
    static let shared = StorageManager()
    
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
                let cities = try JSONDecoder().decode([City].self, from: data)
                DispatchQueue.main.async {
                    completion(cities)
                }
            } catch {
                let cities = [City]()
                DispatchQueue.main.async {
                    completion(cities)
                }
            }
        }
    }
}
