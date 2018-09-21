//
//  Validators.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 9/16/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Validators {
    /* https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift */
    static func isValidEmail(testStr : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    static func isValidFirstname(testStr : String) -> Bool{
        return testStr.count > 2
    }
    
    static func isValidLastName(testStr : String) -> Bool{
        return testStr.count > 1
    }
    
    static func isValidPassword(testStr : String) -> Bool{
        return testStr.count > 7
    }
    
    static func signUpEmailCompletion(textField: LoginTextField){
        let testStr = textField.textField.text!
        Firestore.firestore().document("users/\(testStr)").getDocument { (snapshot, error) in
            if let snapshot = snapshot, snapshot.exists {
                textField.displayErrorMessage(completion: true)
            }
        }
    }
}
