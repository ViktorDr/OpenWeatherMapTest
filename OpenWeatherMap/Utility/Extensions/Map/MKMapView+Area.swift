//
//  MKMapView+Area.swift
//  OpenWeatherMap
//
//  Created by Viktor Drykin on 23.03.2018.
//  Copyright © 2018 Viktor Drykin. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    
    func setMapVisibleArea(lat : Double, lng : Double, visibility : Int) {
        let center = CLLocationCoordinate2DMake(lat, lng)
        let distance =  Double(visibility)
        let mapRegion = MKCoordinateRegionMakeWithDistance(center, distance, distance)
        self.setRegion(mapRegion, animated: false)
        self.setCenter(center, animated: false)
    }
    
}
