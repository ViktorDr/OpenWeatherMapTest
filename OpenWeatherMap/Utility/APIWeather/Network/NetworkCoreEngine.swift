//
//  NetworkCoreEngine.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import Alamofire

enum ErrorType : String {
    case unknownError = "Unknown Error"
}

class NetworkCoreEngine {
    
    
    func performRequest(_ url : String, parameters : [String : Any], requestMethod : HTTPMethod, handleResponse : @escaping ((Any) throws -> Any), completion : @escaping (Bool, Any) -> Void) {
        
        Alamofire.request(url, method: requestMethod, parameters: parameters, headers: nil).responseJSON { response in
            var responseObject : Any
            if response.result.isSuccess {
                do {
                    try responseObject = handleResponse(response.result.value as Any)
                    completion (true, responseObject)
                } catch {
                    completion (false, ErrorType.unknownError.rawValue)
                }
            } else if let error = response.result.error {
                completion (false, error.localizedDescription)
            }
        }
    }
}
