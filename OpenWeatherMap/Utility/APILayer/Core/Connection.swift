//
//  Connection.swift
//  OpenWeatherMap
//
//  Created by admin on 6/16/19.
//  Copyright © 2019 Viktor Drykin. All rights reserved.
//

import Foundation
import Alamofire

public typealias Parameters = [String: Any]
public typealias Headers = [String: String]

protocol Connection {
    
    associatedtype ReturnType: Decodable
    
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var httpBody: Data? { get }
    var headers: Headers? { get }
    
    var isNeededApiKey: Bool { get }
    
    func parse(data: Data) throws -> ReturnType
    
}
