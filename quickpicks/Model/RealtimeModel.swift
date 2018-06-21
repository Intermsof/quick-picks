//
//  RealtimeModel.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/18/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

class RealtimeModel {
    private static var _realTimeModel : RealtimeModel? = nil
    
    static var shared : RealtimeModel {
        if(_realTimeModel == nil){
            _realTimeModel = RealtimeModel()
        }
        return _realTimeModel!
        
    }
    
    private init (){
        
    }
    
    //Sport name to contest date to
    private var contests : [String : [String : ContestInfo]] = [String : [String : ContestInfo]]()
    
    //Adds a newly received contest or override the existing one with the new one
    func updateContestInfo(_ contest : ContestInfo){
        if var sportContests = contests[contest.sportName] {
            sportContests[contest.date] = contest
            contests[contest.sportName] = sportContests
        }
        else {
            contests[contest.sportName] = [contest.date : contest]
        }
    }
    
    func getContest(ofSport : String, andDate: String) -> ContestInfo? {
        guard let sportContests = contests[ofSport], let contest = sportContests[andDate] else {
            return nil
        }
        
        return contest
    }
    
    func printMe(){
        for (_,a) in contests {
            for (_,b) in a {
                b.printMe()
            }
        }
    }
    
    struct Game {
        enum GameState{
            case first
            case second
            case third
            case fourth
            case final
            case unstarted
        }
        
        static func getStateFromRaw(_ raw : Int) -> GameState{
            switch raw {
            case 0:
                return .first
            case 1:
                return .second
            case 2:
                return .third
            case 3:
                return .fourth
            case 4:
                return .final
            default:
                return .unstarted
            }
        }
        
        let homeTeamName : String
        let awayTeamName : String
        let homeSpread : Float
        let awaySpread : Float
        let awayTeamScore : Int
        let homeTeamScore : Int
        
        let gameState : GameState
        
        let gameStartTime : String
        
        init(homeTeamName : String, awayTeamName : String, homeSpread : Float, awaySpread : Float,
             awayTeamScore : Int, homeTeamScore : Int, gameState : GameState, gameStartTime : String){
            
            self.homeTeamName = homeTeamName
            self.awayTeamName = homeTeamName
            self.homeSpread = homeSpread
            self.awaySpread = awaySpread
            self.awayTeamScore = awayTeamScore
            self.homeTeamScore = homeTeamScore
            self.gameState = gameState
            self.gameStartTime = gameStartTime
        }
        
        func printMe(){
            print("Game: \(homeTeamName) vs \(awayTeamName). Spread \(homeSpread) - \(awaySpread). Score \(awayTeamScore) - \(homeTeamScore), \(gameStartTime)")
        }
    }
    
    struct ContestInfo {
        let sportName : String
        let locked : Bool
        let date : String
        let entries : Int
        let games : [Game]
        
        init(sportName : String, locked : Bool, date : String, entries : Int, games : [Game]){
            self.sportName = sportName
            self.locked = locked
            self.date = date
            self.entries = entries
            self.games = games
        }
        
        func printMe(){
            print("Contest: \(sportName), Locked: \(locked), Date: \(date), Entries: \(entries)")
            for game in games {
                game.printMe()
            }
        }
    }
    
    
}
