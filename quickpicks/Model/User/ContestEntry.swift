//
//  ContestEntry.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/14/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

class ContestEntry {
    var picks : [Int]
    var lastGameScore : Int
    var contest : String
    var date : String
    var id : String?
    var position : Int
    
    init(id : String?, picks : [Int], contest : String, date : String, position : Int, lastGameScore : Int){
        self.id = id
        self.picks = picks
        self.contest = contest
        self.date = date
        self.position = position
        self.lastGameScore = lastGameScore
    }
    
    func toFirebaseModel() -> [String : Any] {
        var result = [String : Any]()
        result["picks"] = picks
        result["contest"] = contest
        result["date"] = date
        result["position"] = position
        result["lastGameScore"] = lastGameScore
        return result
    }
}
