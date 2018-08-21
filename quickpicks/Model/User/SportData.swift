//
//  SportData.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/14/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

class SportData {
    var currentPosition : Int = -1
    var currentEntry : ContestEntry? = nil
    
    func toFirebaseModel() -> [String : Any] {
        var result = [String : Any]()
        result["currentPosition"] = currentPosition
        
        if let currentEntry = currentEntry {
            result["currentEntry"] = currentEntry
        }
        return result
    }
    
}
