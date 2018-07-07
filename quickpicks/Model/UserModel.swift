//
//  UserModel.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/18/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

class UserModel {
    private static var _userModel : UserModel? = nil
    
    static var shared : UserModel {
        if(_userModel == nil){
            _userModel = UserModel()
        }
        
        return _userModel!
    }
    
    var id : String!
    var coins : Int!
    var email : String!
    var monthlyPoints : Int!
    var monthlyPositions : Int!
    var prevCoins : Int!
    var username : String!
    var yearlyPoints : Int!
    var yearlyPositions : Int!
    let MLBData : SportData
    let NBAData : SportData
    let NFLData : SportData
    
    enum SportType {
        case MLB
        case NBA
        case NFL
    }
    
    class SportData {
        var dailyPosition : Int = -1
        var enteredToday : Bool!
        var picksHistory : [Picks]!
        var todaysPicks : [Int]!
    }
    
    class Picks {
        var date : String? = nil
        var picks : [Int]!
        
    }
    
    private init (){
        self.MLBData = SportData()
        self.NBAData = SportData()
        self.NFLData = SportData()
    }
}














