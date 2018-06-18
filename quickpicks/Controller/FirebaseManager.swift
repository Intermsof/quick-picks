//
//  FirebaseManager.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/17/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class FirebaseManager {
    private let db : Firestore
    
    func checkAvailable(username : String){
        db.collection("users").whereField("username", isEqualTo: username).getDocuments { (snapshot, error) in
            if let error = error {
                print("error checking username available \(error)")
            }
            
        }
    }
    
    static var shared : FirebaseManager {
        return FirebaseManager()
    }
    
    private init (){
        self.db = Firestore.firestore()
    }
    
    
}
