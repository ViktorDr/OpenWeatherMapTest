//
//  UIViewController+AlertView.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 14.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertView(_ title : String?, _ description : String?) {
        DispatchQueue.main.async {
            let alertController  = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func showAlertView(_ title : String?, _ description : String?, okAction : ((UIAlertAction) ->Void)?  ) {
        DispatchQueue.main.async {
            let alertController  = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: okAction))
            self.present(alertController, animated: true, completion: nil)
            
        }
    }

}
