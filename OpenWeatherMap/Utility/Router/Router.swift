//
//  Router.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 13.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import UIKit
class Router {
    
    static let shared : Router = Router()
    var window : UIWindow?
    
    private let rootStartViewControllerId = "WeatherNavigationController"
    
    private init() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.rootStartViewController()
    }
    
    func rootStartViewController() {
        let storyboard = UIStoryboard.mainStoryboard()
        let startViewController = storyboard.instantiateViewController(withIdentifier: rootStartViewControllerId)
        self.window!.rootViewController = startViewController
        self.window!.makeKeyAndVisible()
    }
}
