//
//  Sport.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/24/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

class Sport {
    var entries: Int
    var id: String
    var isActive: Bool
    var currentContest: Contest!
    var pastContest: Contest?
    
    init(entries: Int, id: String, isActive: Bool, lastContestID: String){
        self.entries = entries
        self.id = id
        self.isActive = isActive
    }
}
