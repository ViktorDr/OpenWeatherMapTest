//
//  UITableView+Extensions.swift
//  OpenWeatherMap
//
//  Created by admin on 6/17/19.
//  Copyright © 2019 Viktor Drykin. All rights reserved.
//

import UIKit

extension UITableView {
    func register<View: ReusableView>(_ type: View.Type) {
        if type is UITableViewCell.Type {
            register(type.nib, forCellReuseIdentifier: type.reuseKey)
        }
    }
}
