//
//  Live.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 9/4/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Live : NavbarViewController, LiveViewDelegate {
    var liveViewContainer : LiveView!
    var gameListeners : [ListenerRegistration]! = []
    var contestListener : ListenerRegistration!
    
    override func getNavbarTitle() -> String {
        return NavbarTitleConstants.LIVE
    }
    override func viewDidLoad() {
        liveViewContainer = LiveView(navBarDelegate: self, liveViewDelegate: self)
        liveViewContainer.addTo(self)
    }
    
    func getSportNames(sport : Sport){
        Firestore.firestore().document("sports/\(sport.id)/Teams/tbjsx8IrAhHeyjkKhEEJ")
            .getDocument { (snapshot, error) in
                guard let snapshot = snapshot else {
                    print("error \(error)")
                    return
                }
                
                guard let data = snapshot.data() else {
                    print("No Data")
                    return
                }
                
                sport.teams = data as! [String : String]
                self.liveViewContainer.myPicksTable.reloadData()
        }
    }
    func listenToSport(sport : Sport){
        /* Add listeners for games */
        let pathToGames = "sports/\(sport.id)/games"
        let gameIDs = sport.currentContest.gameIDs
        let games = sport.currentContest.games
        
        for gameID in gameIDs {
            gameListeners.append(Firestore.firestore().document("\(pathToGames)/\(gameID)")
                .addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    guard let data = document.data() else {
                        print("Document data was empty.")
                        return
                    }
                    let game = games[gameID]!
                    game.awayTeamScore = data["awayTeamScore"] as! Int
                    game.homeTeamScore = data["homeTeamScore"] as! Int
                    game.gameState = data["gameState"] as! Int
                    self.liveViewContainer.liveGamesTable.setSport(sport: sport)
            })
        }
        
        contestListener = Firestore.firestore().document("sports/\(sport.id)/contests/\(sport.currentContest.id)")
            .addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else {
                    print("Error listening to contest progression: \(error)")
                    return
                }
                guard let data = snapshot.data() else {
                    print ("Document data was empty.")
                    return
                }
                let progression = data["progression"] as! Int
                if(progression != sport.currentContest.progression){
                    sport.currentContest.progression = progression
                    //Get leaderboard documents
                    /* Add listeners for leaderboard changes */
                    Firestore.firestore().collection("sports/\(sport.id)/dailyLB")
                        .getDocuments { (snapshot, error) in
                            guard let snapshot = snapshot else {
                                print("Error fetching documents: \(error)")
                                return
                            }
                            
                            var rankings = [Ranking]()
                            for document in snapshot.documents {
                                let data = document.data()
                                let ranking = Ranking(id: document.documentID, position: data["position"] as! Int, score: data["score"] as! Int, username: data["username"] as! String)
                                
                                rankings.append(ranking)
                            }
                            
                            rankings.sort(by: { (a, b) -> Bool in
                                return a.score < b.score
                            });
                            
                            sport.dailyLB = rankings
                            self.liveViewContainer.rankingsTable.reloadData()
                    }
                }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hardcode to NFL
        listenToSport(sport: Sport.sports[0])
        getSportNames(sport : Sport.sports[0])
        
        liveViewContainer.rankingsTable.reloadData()
        liveViewContainer.myPicksTable.setContestEntry(contestEntry: User.shared.NFLcontestEntry)
        liveViewContainer.liveGamesTable.reloadData()
        
        print("viewwillappear called")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for listener in gameListeners {
            listener.remove()
        }
        print("viewwilldisappear called")
        contestListener.remove()
    }
}
