//
//  Sport.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/24/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

class Sport {
    static var sports : [Sport] = []
    static var selectedSport : Sport?
    
    var entries: Int
    var id: String
    var isActive: Bool
    var currentContest: Contest!
    var pastContest: Contest?
    var dailyLB : [Ranking] = []
    var teams : [String : String]?
    
    init(entries: Int, id: String, isActive: Bool, lastContestID: String){
        self.entries = entries
        self.id = id
        self.isActive = isActive
    }
    
    static func isNFLPicked() -> Bool {
        if let sport = Sport.selectedSport {
            return sport.id == "NFL"
        }
        return false
    }
    static func isNBAPicked() -> Bool {
        if let sport = Sport.selectedSport {
            return sport.id == "NBA"
        }
        return false
    }
    static func isMLBPicked() -> Bool {
        if let sport = Sport.selectedSport {
            return sport.id == "MLB"
        }
        return false
    }
}
