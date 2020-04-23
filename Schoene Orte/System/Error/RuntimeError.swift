//
//  RuntimeError.swift
//  Schoene Orte
//
//  Created by Sebastian Rieger on 23.04.20.
//  Copyright © 2020 Sebastian Rieger. All rights reserved.
//

import Foundation

struct RuntimeError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
