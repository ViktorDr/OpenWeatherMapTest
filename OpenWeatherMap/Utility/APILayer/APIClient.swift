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
    
    func start<C: Call>(call: C, successHandler: @escaping ((C.ReturnType) -> Void), failureHandler: @escaping ((_ error: Error) -> Void)) {
        let url = "Combine base url + url of method in function here"
                Alamofire.request(url, method: call.method, parameters: call.parameters, headers: call.headers).responseJSON { response in
                }
    }
    
//    func performRequest(_ url : String, parameters : [String : Any], requestMethod : HTTPMethod, handleResponse : @escaping ((Any) throws -> Any), completion : @escaping (Bool, Any) -> Void) {
//
//        Alamofire.request(url, method: requestMethod, parameters: parameters, headers: nil).responseJSON { response in
//            var responseObject : Any
//            if response.result.isSuccess {
//                do {
//                    try responseObject = handleResponse(response.result.value as Any)
//                    completion (true, responseObject)
//                } catch {
//                    completion (false, ErrorType.unknownError.rawValue)
//                }
//            } else if let error = response.result.error {
//                completion (false, error.localizedDescription)
//            }
//        }
//    }
    
}
