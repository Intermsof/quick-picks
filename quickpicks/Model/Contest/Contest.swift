//
//  Contest.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/24/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

class Contest {
    let id : String
    let date : String
    let gameIDs : [String]
    var games = [String : Game]()
    var progression : Int
    
    init(id: String, date: String, gameIDs : [String], progression: Int){
        self.id = id
        self.date = date
        self.gameIDs = gameIDs
        self.progression = progression
    }
    

}
