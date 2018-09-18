//
//  SettingsFirebase.swift
//  quickpicks
//
//  Created by Shreya Jain on 9/4/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct  SettingFirebase{
    static func setupRewards(paypalemail: String, qpemail: String, amount: Int){
        Reward.shared.createRewards(paypalemail:paypalemail,qpemail:qpemail,amount:amount)
        Firestore.firestore().collection(FirebaseConstants.COLLECTION_REWARDS).document().setData(Reward.shared.toFirebaseModel())
        { err in
            if let err = err {
                print("Error creating document: \(err)")
            } else {
                print("Document successfully created")
            }
        }
    }
    
    static func updatePassword(password : String){
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
        }
    }
 
    
    static func setupSignOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    static func updateCoins(amount:Int){
        Firestore.firestore().collection(FirebaseConstants.COLLECTION_USERS).document(User.shared.email).updateData([
            "coins": amount
            ])
        { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
   static func updateNotifications(nval:Bool){
        
        Firestore.firestore().collection(FirebaseConstants.COLLECTION_USERS).document(User.shared.email).updateData([
            "notifications": nval
            ])
        { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
}
