//
//  ViewController.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/12/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

/*
 -------------------------- DESCRIPTION OF PAGE FUNCTIONALITY ---------------------------------
 

 
 -------------------------- DOCUMENTATION UPDATED 06/12/18 -------------------------------------
 */


import UIKit
import FacebookLogin
import FirebaseAuth

class LoginOptions : UIViewController {
    
    func notifySuccess() {
        self.performSegue(withIdentifier: "ToPicksFromLoginOptions", sender: self)
    }
    
    
    
    var blurEffect : UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewContainer = LoginOptionsView()
        viewContainer.addTo(self)
        ViewContainer.setupRadialGradient(self.view)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    
    private func _setupButtons(){
        
    }
    
    @IBAction func segueToEmailSignup(){
        self.performSegue(withIdentifier: SegueConstants.LOGINOPTIONS_LOGINEMAILSIGNUP, sender: self)
    }
    
    @IBAction func segueToEmail(){
        self.performSegue(withIdentifier: SegueConstants.LOGINOPTIONS_LOGINEMAILSIGNIN, sender: self)
    }
    
    //Method for signing user in. See firebase authentication guides for detail
    @IBAction func signUpWithFacebook() {
        let loginManager = LoginManager()
        
        //continueRotate = true
        let animationDuration = 0.3

        UIView.animate(withDuration: animationDuration) {
            self.blurEffect.alpha = 0.8
//            self.facebookButton.alpha = 0
//            self.emailLoginButton.alpha = 0
//            self.emailSignupButton.alpha = 0
        }
       // self.rotateCoin()
        
        loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self){
            loginResult in
            switch loginResult{
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(_, _, let accessToken):
                print("logged in!")
                print(accessToken.userId!)
                print(accessToken.authenticationToken)
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                
                Auth.auth().signInAndRetrieveData(with: credential, completion: { (result, error) in
                    guard let result = result else {
                        if let error = error {
                            print(error)
                        }
                        return
                    }
                    
                    print("login with userid \(result.user.uid)")
                 /*
                    FirebaseManager.shared.setupUserData(user: result.user, email: result.user.email!, username: result.user.displayName!, controller: self)*/
                    //TODO: CREATE A PAGE FOR FACEBOOK USERS TO TYPE USER NAME
                    
                    //FirebaseManager.shared.fetchUser(withID: result.user.uid, controller: self)
                    
                })
            }
        }
    }
    
    /*
    var continueRotate : Bool = true
    func rotateCoin(){
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0, options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.loadingCoin.transform = self.loadingCoin.transform.rotated(by: 3.14 / 2.0)
        }, completion: {(_) in
            if(self.continueRotate){
                self.rotateCoin()
            }
        })
    }
     */
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}






















