//
//  FileHandler.swift
//  Schoene Orte
//
//  Created by Sebastian Rieger on 23.04.20.
//  Copyright © 2020 Sebastian Rieger. All rights reserved.
//

import Foundation

class FileHandler {
    
    static func placesURL() throws -> URL {
        var url: URL
        
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if let documentURL = fileURLs.first {
            url = documentURL.appendingPathComponent(Constants.Files.places)
        } else {
            throw RuntimeError("Can not find File: \(Constants.Files.places)")
        }
        return url
    }
}
