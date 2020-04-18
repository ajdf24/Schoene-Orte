//
//  Place.swift
//  Schoene Orte
//
//  Created by Sebastian Rieger on 18.04.20.
//  Copyright © 2020 Sebastian Rieger. All rights reserved.
//

import Foundation
import CoreLocation

struct Place{
    let name: String
    let imageName: String?
    let website: String?
    let phone: String?
    let timestamp: Double
    let coordinate: CLLocationCoordinate2D?


    init(name: String, imageName: String? = nil, website: String? = nil, phone: String? = nil, timestamp: Double? = nil, coordinate: CLLocationCoordinate2D? = nil) {
    
        self.name = name
        self.imageName = imageName
        self.website = website
        self.phone = phone
        self.coordinate = coordinate
        
        if let theTimestamp = timestamp{
            self.timestamp = theTimestamp
        } else {
            self.timestamp = Date().timeIntervalSince1970
        }
    }
}
