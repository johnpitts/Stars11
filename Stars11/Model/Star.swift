//
//  Star.swift
//  Stars11
//
//  Created by John Pitts on 10/15/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation


struct Star: Codable {
    
    let name: String
    let distance: Double
    
    var distanceDescription: String {
        return "\(distance) light years away"
    }
    
}
