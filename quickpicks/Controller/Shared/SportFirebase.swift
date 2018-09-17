//
//  SportFirebase.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/24/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct SportFirebase{
    static func submitSportEntry(sport: Sport, user: User, data: [String: Any], id: String?) -> String{
        if let id = id {
            Firestore.firestore()
                .document("users/\(user.email!)/\(sport.id)Entries/\(id)")
                .setData(data)
            return id
        }
        else {
            let documentID = Firestore.firestore()
                .collection("users")
                .document("\(user.email!)")
                .collection("\(sport.id)Entries")
                .addDocument(data: data)
                .documentID
            
            Firestore.firestore()
                .document("users/\(user.email!)")
                .updateData(["\(sport.id)Picks" : documentID, "\(sport.id)Entered" : true])
            
            return documentID
        }
    }
    
    static func getActiveSports(completion:@escaping (_ sports : [Sport]?) -> Void){
        Firestore.firestore()
            .collection("sports")
            .whereField("isActive", isEqualTo: true)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print(error)
                    completion(nil)
                    return
                }
                
                if let snapshot = snapshot {
                    var sports : [Sport]? = nil
                    for document in snapshot.documents {
                        let data = document.data()
                        if let currentContestID = data["currentContest"] as? String, let entries = data["entries"] as? Int,
                            let id = data["id"] as? String, let isActive = data["isActive"] as? Bool,
                            let lastContestID = data["lastContest"] as? String{
                            if (sports == nil){
                                sports = [Sport]()
                            }
                            let sport = Sport(entries: entries, id: id, isActive: isActive, lastContestID: lastContestID)
                            sports!.append(sport)
                            SportFirebase._getContest(sport: id, id: currentContestID, completion: { (contest) in
                                if let contest = contest {
                                    sport.currentContest = contest
                                }
                                else{
                                    print("could not get contest")
                                }
                            })
                        }
                    }
                    completion(sports)
                }
        }
    }
    
    private static func _getContest(sport:String, id:String, completion:@escaping (_ contest: Contest?)->Void){
        Firestore.firestore()
            .document("sports/\(sport)/contests/\(id)")
            .getDocument { (snapshot, error) in
                if let error = error {
                    print(error)
                    completion(nil)
                    return
                }
//print(snapshot!.data())
                if let snapshot = snapshot, let data = snapshot.data(), let date = data["date"] as? String, let gameIDs = data["games"] as? [String]{
                    let id = snapshot.documentID
                    let contest = Contest(id: id, date: date, gameIDs: gameIDs, progression: 0)
                    
                    var fetchedGamesCounter = 0
                    for gameID in gameIDs{
                        SportFirebase._getGame(sport: sport, id: gameID) { (game, id) in
                            print("got game: \(id)")
                            if let game = game {
                                contest.games[id] = game
                                fetchedGamesCounter += 1
                                
                                if(fetchedGamesCounter == gameIDs.count){
                                    completion(contest)
                                }
                            }
                            else{
                                completion(nil)
                            }
                        }
                    }
                }
                else{
                    print("no error object, but no data or malformed data in get contest \(sport), \(id)")
                    completion(nil)
                }
        }
    }
    
    private static func _getGame(sport:String, id:String, completion:@escaping (_ game : Game?, _ id : String)->Void){
        Firestore.firestore()
            .document("sports/\(sport)/games/\(id)")
            .getDocument { (snapshot, error) in
                if let error = error {
                    print(error)
                    completion(nil, id)
                    return
                }
                //print(snapshot!.data())
                
                if let snapshot = snapshot, let data = snapshot.data(), let awayTeamName = data["awayTeamName"] as? String,
                    let awayTeamScore = data["awayTeamScore"] as? Int, let gameStartDate = data["gameStartDate"] as? String,
                    let gameStartTime = data["gameStartTime"] as? String, let gameState = data["gameState"] as? Int,
                    let homeTeamName = data["homeTeamName"] as? String, let homeTeamScore = data["homeTeamScore"] as? Int,
                    let isFinished = data["isFinished"] as? Bool,
                    let spread = data["spread"] as? Float{
                    let game = Game(id: snapshot.documentID, awayTeamName: awayTeamName, awayTeamScore: awayTeamScore, gameStartDate: gameStartDate, gameStartTime: gameStartTime, gameState: gameState, homeTeamName: homeTeamName, homeTeamScore: homeTeamScore, isFinished: isFinished, spread: spread)
                    completion(game, id)
                }
                else{
                    print("no error object, but no data or malformed data in get game \(sport), \(id)")
                    completion(nil, id)
                }
        }
    }
}
