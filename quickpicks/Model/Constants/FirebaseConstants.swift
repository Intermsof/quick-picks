//
//  FirebaseConstants.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/16/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

struct FirebaseConstants{
    static let COLLECTION_GAMES = "games"
    static let COLLECTION_CONTESTS = "contests"
    static let COLLECTION_DAILYLB = "dailyLB"
    
    static let COLLECTION_SPORTS = "sports"
    struct SPORTS {
        static let FIELD_CURRENTCONTEST = "currentContest"
        static let FIELD_ENTRIES = "entries"
        static let FIELD_ID = "id"
        static let FIELD_ISACTIVE = "isActive"
        static let FIELD_LASTCONTEST = "lastContest"
        static let FIELD_AWARDS = "awards"
    }
    
    static let COLLECTION_USERS = "users"
    struct USERS {
        static let FIELD_EMAIL = "email"
        static let FIELD_USERNAME = "username"
        static let FIELD_COINS = "coins"
        static let FIELD_PREVCOINS = "prevCoins"
        static let FIELD_NFL_POSITION = "NFLPosition"
        static let FIELD_NFL_PICKS = "NFLPicks"
        static let FIELD_NBA_PICKS = "NBAPicks"
        static let FIELD_MLB_PICKS = "MLBPicks"
        static let Field_NOTIFICATIONS = "notifications"
    }
    
    struct GAMES {
        static let FIELD_AWAYTEAMNAME = "awayTeamName"
        static let FIELD_AWAYTEAMSCORE = "awayTeamScore"
        static let FIELD_GAMESTARTDATE = "gameStartDate"
        static let FIELD_GAMESTARTTIME = "gameStartTime"
        static let FIELD_GAMESTATE = "gameState"
        static let FIELD_HOMETEAMNAME = "homeTeamName"
        static let FIELD_HOMETEAMSCORE = "homeTeamScore"
        static let FIELD_ISFINISHED = "isFinished"
        static let FIELD_SPREAD = "spread"
    }
    static let COLLECTION_REWARDS = "rewards"
    struct REWARDS{
        static let FIELD_PAYPALEMAIL = "paypalEmail"
        static let FIELD_QPLEMAIL = "qpEmail"
        static let FIELD_AMOUNT = "amount"
    }
}
