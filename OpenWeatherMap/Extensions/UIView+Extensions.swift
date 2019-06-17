//
//  UIView+Extensions.swift
//  OpenWeatherMap
//
//  Created by admin on 6/17/19.
//  Copyright © 2019 Viktor Drykin. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubview(_ view: UIView, edgeInsets: UIEdgeInsets) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edgeInsets.bottom),
            view.leftAnchor.constraint(equalTo: leftAnchor, constant: edgeInsets.left),
            view.rightAnchor.constraint(equalTo: rightAnchor, constant: edgeInsets.right)
            ])
    }
}
