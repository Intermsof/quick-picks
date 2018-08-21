//
//  UserModel.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/18/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

class User {
    private static var _user : User? = nil
    var email : String!
    var username : String!
    var NFLPosition : Int!
    var NFLPicks : String!
    var coins : Int!
    var prevCoins : Int!
    
    static var shared : User {
        if(_user == nil){
            _user = User()
        }
        return _user!
    }
    
    //Function to be used only when user logs in for the first time
    func createUser(email: String, username: String){
        self.email = email
        self.username = username
        self.NFLPosition = -1
        self.NFLPicks = ""
        self.coins = 0
        self.prevCoins = 0
    }
    
    func toFirebaseModel() -> [String : Any]{
        var result = [String : Any]()
        result["email"] = email
        result["username"] = username
        result["NFLPosition"] = NFLPosition
        result["NFLPicks"] = NFLPicks
        result["coins"] = coins
        result["prevCoins"] = coins
        
        return result
    }
    
    private init (){
        
    }
}













