//
//  Game.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/24/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

class Game {
    let id : String
    let awayTeamName : String
    var awayTeamScore: Int
    let gameStartDate : String
    let gameStartTime : String
    var gameState : Int
    let homeTeamName : String
    var homeTeamScore : Int
    var isFinished : Bool
    let spread : Float
    
    init(id:String,awayTeamName: String, awayTeamScore:Int,gameStartDate:String
        ,gameStartTime:String,gameState:Int,homeTeamName:String
        ,homeTeamScore:Int,isFinished:Bool,spread:Float){
        self.id = id
        self.awayTeamName = awayTeamName
        self.awayTeamScore = awayTeamScore
        self.gameStartDate = gameStartDate
        self.gameStartTime = gameStartTime
        self.gameState = gameState
        self.homeTeamName = homeTeamName
        self.homeTeamScore = homeTeamScore
        self.isFinished = isFinished
        self.spread = spread
    }
    
    func setHomeScore(_ score : Int){
        self.homeTeamScore = score
    }
    
    func setAwayScore(_ score : Int){
        self.awayTeamScore = score
    }
}
