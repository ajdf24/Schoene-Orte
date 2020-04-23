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
    
    init(dictionary: [String:Any]) {
        name = dictionary["name"] as! String
        timestamp = dictionary["timestamp"] as! Double
        imageName = dictionary["imageName"] as? String
        website = dictionary["website"] as? String
        phone = dictionary["phone"] as? String
        
        if let longitude = dictionary["longitude"] as? Double, let latitude = dictionary["latitude"] as? Double {
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            coordinate = nil
        }
    }
    
    func plistDictionary() -> [String:Any] {
        
        var theDictionary: [String:Any] = [:]
        theDictionary["name"] = name
        theDictionary["timestamp"] = timestamp
        
        if let theImageName = imageName {
            theDictionary["imageName"] = theImageName
        }
        
        if let theWebsite = website {
            theDictionary["website"] = theWebsite
        }
        
        if let thePhone = phone {
            theDictionary["phone"] = thePhone
        }
        
        if let theCoordinate = coordinate {
            theDictionary["longitude"] = theCoordinate.longitude
            theDictionary["latitude"] = theCoordinate.latitude
        }
        
        return theDictionary
    }
}
