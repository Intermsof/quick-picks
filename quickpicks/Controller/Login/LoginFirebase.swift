//
//  LoginFirebase.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/16/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

struct LoginFirebase {
    static func checkAvailable(username : String, delegate : Promise){
        Firestore.firestore()
            .collection(FirebaseConstants.COLLECTION_USERS)
            .whereField(FirebaseConstants.USERS.FIELD_USERNAME, isEqualTo: username)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    delegate.reject(error: "error checking username availability: \(error)")
                }
                if(snapshot!.count > 0){
                    delegate.resolve(result: false)
                }
                else{
                    delegate.resolve(result: true)
                }
            }
    }
    
    static func checkAvailable(email : String, delegate : Promise){
        Firestore.firestore()
            .collection(FirebaseConstants.COLLECTION_USERS)
            .whereField(FirebaseConstants.USERS.FIELD_EMAIL, isEqualTo: email)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    delegate.reject(error: "error checking email availability: \(error)")
                }
            
                if(snapshot!.count > 0){
                    delegate.resolve(result: false)
                }
                else{
                    delegate.resolve(result: true)
                }
            }
    }
    
    static func signupUser(email: String, username: String, password: String, delegate : Promise){
        Auth.auth()
            .createUser(withEmail: email, password: password) { (res,error) in
                if let error = error {
                    delegate.reject(error: "error creating user: \(error)")
                }
                if let res = res {
                    res.user.sendEmailVerification(completion: { (error) in
                        if let error = error {
                            delegate.reject(error: "error sending verification email \(error)")
                        }
                        else{
                            User.shared.createUser(email: email, username: username)
                            Firestore.firestore()
                                .collection(FirebaseConstants.COLLECTION_USERS)
                                .document(email)
                                .setData(User.shared.toFirebaseModel()) { err in
                                    if let err = err{
                                        delegate.reject(error: "Sent verification but could not create user object \(err)")
                                    }
                                    else{
                                        delegate.resolve(result: true)
                                    }
                                }
                        }
                    })
                }
                else {
                    delegate.reject(error: "error creating user: no error object but did not get a response")
                }
        }
    }
    
    static func signinUser(email: String, password: String, delegate: Promise)  {
        Auth.auth().signIn(withEmail: email, password: password) { (res, error) in
            if let error = error {
                delegate.reject(error: "\(error)")
            }
            
            if let res = res {
                let email = res.user.email!
                LoginFirebase.fetchUser(email: email, delegate: delegate)
            }
            else {
                delegate.reject(error: "Error: no error object but no response")
            }
        }
    }
    
    static func fetchUser(email: String, delegate: Promise){
        Firestore.firestore()
            .collection(FirebaseConstants.COLLECTION_USERS)
            .document(email)
            .getDocument { (snapshot, error) in
                if let error = error {
                    delegate.reject(error: "\(error)")
                }
                else if let data = snapshot?.data(){
                    User.shared.coins = data[FirebaseConstants.USERS.FIELD_COINS] as! Int
                    User.shared.prevCoins = data[FirebaseConstants.USERS.FIELD_PREVCOINS] as! Int
                    User.shared.email = data[FirebaseConstants.USERS.FIELD_EMAIL] as! String
                    User.shared.username = data[FirebaseConstants.USERS.FIELD_USERNAME] as! String
                    User.shared.NFLPosition = data[FirebaseConstants.USERS.FIELD_NFL_POSITION] as! Int
                    User.shared.NFLPicks = data[FirebaseConstants.USERS.FIELD_NFL_PICKS] as! String
                    User.shared.notifications = data[FirebaseConstants.USERS.Field_NOTIFICATIONS] as! Bool
                    User.shared.NFLEntered = data["NFLEntered"] as! Bool
                    //User.shared.NBAPicks = data[FirebaseConstants.USERS.FIELD_NBA_PICKS] as! String
                    //User.shared.MLBPicks = data[FirebaseConstants.USERS.FIELD_MLB_PICKS] as! String
                    if(!User.shared.NFLPicks.isEmpty){
                        Firestore.firestore()
                            .document("users/\(email)/NFLEntries/\(User.shared.NFLPicks!)")
                            .getDocument(completion: { (snapshot, error) in
                                if let error = error {
                                    print("error trying to get User Entries \(error)")
                                }
                                else if let snapshot = snapshot, let data = snapshot.data(), let contest = data["contest"] as? String
                                    , let date = data["date"] as? String, let lastGameScore = data["lastGameScore"] as? Int
                                    , let position = data["position"] as? Int, let picks = data["picks"] as? [Int]{
                                    let id = snapshot.documentID
                                    User.shared.NFLcontestEntry = ContestEntry(id: id, picks: picks, contest: contest, date: date, position: position, lastGameScore: lastGameScore)
                                }
                                else{
                                    print("no error but no snapshot in getting User Entries")
                                }
                            })
                    }
                    
                    delegate.resolve(result: true)
                }
                else {
                    delegate.reject(error: "No error object, but no response")
                }
        }
    }
}

