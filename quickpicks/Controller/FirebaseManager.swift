//
//  FirebaseManager.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/17/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol FirebaseCallable{
    func notifySuccess()
    func notifyFailure()
}

class FirebaseManager {
    
    let sportsCollectionName = "sports"
    let usersCollectionName = "users"
    let userUsernameFieldName = "username"
    let userEmailFieldName = "email"
    
    let activeSportsCollectionName = "active"
    
    private let db : Firestore
    
    func checkAvailable(username : LoginTextField){
        guard let text = username.textField.text else {
            return
        }

        db.collection(usersCollectionName).whereField(userUsernameFieldName, isEqualTo: text).getDocuments { (snapshot, error) in
            if let error = error {
                print("error checking username available \(error)")
            }
            if(snapshot!.count > 0){
                username.addCompletionErrorMessage()
            }
        }
    }
    
    func checkAvailable(email : LoginTextField){
        guard let text = email.textField.text else{
            return
        }
        db.collection(usersCollectionName).whereField(userEmailFieldName, isEqualTo: text).getDocuments { (snapshot, error) in
            if let error = error {
                print("error checking email available \(error)")
            }
            
        if(snapshot!.count > 0){
                email.addCompletionErrorMessage()
           }
        }
    }
    
    //Nested callbacks here.
    func createUser(withEmail : String, password : String, username : String, controller : LoginEmailSignup){
        Auth.auth().createUser(withEmail: withEmail, password: password) { (res,error) in
            guard let res = res else{
                print(error!)
                controller.notifyFailure()
                return
            }
            
            let user = res.user
            user.sendEmailVerification(completion: { (error) in
                if let error = error {
                    print("error sending email verification \(error)")
                    controller.notifyFailure()
                }
                else{
                    let userData : [String : Any] = ["email": withEmail,
                                                     "username" : username,
                                                     "coins" : 0,
                                                     "NFL" : ["enteredToday" : false, "todayPicks":[],"picksHistory":[]],
                                                     "NBA" : ["enteredToday" : false, "todayPicks":[],"picksHistory":[]],
                                                     "MLB" : ["enteredToday" : false, "todayPicks":[],"picksHistory":[]],
                                                     "prizeHistory" : [],
                                                     "monthlyPoints" : 0,
                                                     "yearlyPoints" : 0,
                                                     "prevCoins" : 0,
                                                     "dailyPosition" : -1,
                                                     "monthlyPosition" : -1,
                                                     "yearlyPosition" : -1]
                    
                    self.db.collection("users").document(user.uid).setData(userData){ error in
                        if let error = error {
                            print("error creating user data \(error)")
                            controller.notifyFailure()
                        }
                        else{
                            self.getSportsDocuments(controller: controller)
                        }
                    }
                }
            })
        }
    }
    
    func listenForRealtimeUpdates(){
        
    }
    
    //Gets every active game in every active 
    func getSportsDocuments(controller : FirebaseCallable){
        self.db.collection(sportsCollectionName).whereField("isActive", isEqualTo: true).getDocuments {
            (snapshot, error) in
            guard let snapshot = snapshot else {
                if let error = error {
                    print("error fetching sports documents \(error)")
                }
                controller.notifyFailure()
                return;
            }
            
            var completed = 0
            let total = snapshot.documents.count
            for document in snapshot.documents {
                let data = document.data()
                let entries = data["entries"] as! Int
                let sportId = document.documentID
                document.reference.collection(self.activeSportsCollectionName)
                    .getDocuments(completion: { (snapshot, error) in
                        guard let snapshot = snapshot else{
                            if let error = error {
                                print("error fetching \(sportId), \(error)")
                            }
                            controller.notifyFailure()
                            return
                        }
                        
                        for document in snapshot.documents {
                            let data = document.data()
                            let contestDate = document.documentID
                            let locked = data["locked"] as! Bool
                            
                            let _games = data["games"] as! [[String : Any]]
                            var games = [RealtimeModel.Game]()
                            for _game in _games {
                                games.append(self.parseGame(_game))
                            }
                            
                            let contest = RealtimeModel.ContestInfo(sportName: sportId
                                , locked: locked
                                , date: contestDate
                                , entries: entries
                                , games: games)
                            
                            RealtimeModel.shared.updateContestInfo(contest)
                        }
                        
                        completed += 1
                        if(completed == total){
                            controller.notifySuccess()
                        }
                })
            }
            
        }
    }
    
    func signinUser(withEmail: String, password: String, controller: FirebaseCallable)  {
        Auth.auth().signIn(withEmail: withEmail, password: password) { (res, error) in
            guard let res = res else {
                if let error = error {
                    print ("error signing user in \(error)")
                }
                controller.notifyFailure()
                return
            }
            
            self.fetchUser(withID: res.user.uid, controller: controller)
        }
    }
    
    func fetchUser(withID : String, controller: FirebaseCallable){
        db.collection(usersCollectionName).document(withID).getDocument { (snapshot, error) in
            guard let snapshot = snapshot else {
                if let error = error {
                    print("could not fetch user with id \(withID), \(error)")
                }
                controller.notifyFailure()
                return
            }
            let data = snapshot.data()
            print("\(data)")
            
            self.getSportsDocuments(controller: controller)
        }
    }
    
    //Only pass this function a document in the sports collection
    let awayTeamName = "awayTeamName"
    let awayTeamScore = "awayTeamScore"
    let gameStartTime = "gameStartTime"
    let gameState = "gameState"
    let homeTeamName = "homeTeamName"
    let homeTeamScore = "homeTeamScore"
    let spread = "spread"
    func parseGame(_ _game : [String : Any]) -> RealtimeModel.Game{
        return RealtimeModel.Game(homeTeamName: _game[homeTeamName] as! String
            , awayTeamName: _game[awayTeamName] as! String
            , homeSpread: _game[spread] as! Float
            , awaySpread: -(_game[spread] as! Float)
            , awayTeamScore: _game[awayTeamScore] as! Int
            , homeTeamScore: _game[homeTeamScore] as! Int
            , gameState: RealtimeModel.Game.getStateFromRaw(_game[gameState] as! Int)
            , gameStartTime: _game[gameStartTime] as! String)
        
        
    }
    
    private func setupRealtimeModel(){
        
    }
    
    static var _firebaseManager : FirebaseManager? = nil
    static var shared : FirebaseManager {
        if(_firebaseManager == nil){
            _firebaseManager = FirebaseManager()
        }
        return _firebaseManager!
    }
    
    private init (){
        self.db = Firestore.firestore()
    }
    
    
}
