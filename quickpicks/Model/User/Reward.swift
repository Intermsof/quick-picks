//
//  Reward.swift
//  quickpicks
//
//  Created by Shreya Jain on 9/2/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
class Reward {
private static var _reward : Reward? = nil
var paypalemail : String!
var qpemail : String!
var amount : Int!

static var shared : Reward {
    if(_reward == nil){
        _reward = Reward()
    }
    return _reward!
}

    func createRewards(paypalemail:String,qpemail:String,amount:Int){
        self.paypalemail=paypalemail
        self.qpemail=qpemail
        self.amount=amount
    }
    
    func toFirebaseModel() -> [String : Any]{
        var result = [String : Any]()
        result["paypalEmail"] = paypalemail
        result["qpEmail"] = qpemail
        result["amount"] = amount

        return result
    }

}
