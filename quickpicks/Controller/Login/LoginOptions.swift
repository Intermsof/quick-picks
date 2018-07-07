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

class LoginOptions : UIViewController, FirebaseCallable {
    
    var loadingCoin : UIImageView!
    
    
    func notifySuccess() {
        continueRotate = false
        self.performSegue(withIdentifier: "ToPicksFromLoginOptions", sender: self)
    }
    
    func notifyFailure() {
        print("got fucked while logging in")
    }
    
    //View related constants
    let buttonWidthPercentage : CGFloat = 0.7143 //Percentage of the screen width to make buttons
    let fbButtonHeightToWidthRatio : CGFloat = 0.18 //Multiply this by the width to get the height
    let emailButtonHeightToWidthRatio : CGFloat = 0.15 //Multiply this by the width to get the height
    let facebookButtonOffset : CGFloat = 0.25 //Percentage of screen Height to offset top of button from parent centerY
    let buttonsSeparation : CGFloat = 0.02 //Percentage of screen height to offset each button
    
    //Views
    let facebookButton = UIButton()
    let emailLoginButton = UIButton()
    let emailSignupButton = UIButton()
    
    var blurEffect : UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupButtons()
        let radialGradient = LayerRadialGradient()
        radialGradient.frame = self.view.frame
        self.view.layer.insertSublayer(radialGradient, at: 0)
        blurEffect = LoginEmailSignup.createBlurEffect(container: self.view)
        loadingCoin = LoginEmailSignup.createLoadingCoin(container: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupButtons(){
        //Add facebook button
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(facebookButton)
        
        //set up facebook width and height anchors
        facebookButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: buttonWidthPercentage).isActive = true
        facebookButton.heightAnchor.constraint(equalTo: facebookButton.widthAnchor, multiplier: fbButtonHeightToWidthRatio).isActive = true
        
        //position the facebook button
        facebookButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        facebookButton.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: facebookButtonOffset * self.view.frame.height).isActive = true
        
        //set up button looks
        facebookButton.backgroundColor = Colors.FBBlue
        facebookButton.setTitle("sign in with facebook", for: .normal)
        facebookButton.setTitleColor(UIColor.white, for: .normal)
        facebookButton.titleLabel!.font = Fonts.CollegeBoyWithSize(size: 27)
        LayerEffects.AddShadowToView(facebookButton, withRadius: 5, color: UIColor.black, opacity: 0.3, offset : CGSize.zero)
        LayerEffects.AddRoundedBorderToView(facebookButton, withRadius: 8)
        
        //add target
        facebookButton.addTarget(self, action: #selector(LoginOptions.signUpWithFacebook), for: .touchUpInside)
        
        //Add email signup button
        self.view.addSubview(emailSignupButton)
        emailSignupButton.translatesAutoresizingMaskIntoConstraints = false
        
        //position emailSignupButton
        emailSignupButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: buttonWidthPercentage).isActive = true
        emailSignupButton.heightAnchor.constraint(equalTo: emailSignupButton.widthAnchor, multiplier: emailButtonHeightToWidthRatio).isActive = true
        
        //set up sign up with email width and height anchors
        emailSignupButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emailSignupButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor, constant: buttonsSeparation * self.view.frame.height).isActive = true
        
        //set up button looks
        emailSignupButton.backgroundColor = UIColor.black
        emailSignupButton.setTitle("sign up with email", for: .normal)
        emailSignupButton.setTitleColor(UIColor.white, for: .normal)
        emailSignupButton.titleLabel!.font = Fonts.CollegeBoyWithSize(size: 22)
        LayerEffects.AddShadowToView(emailSignupButton, withRadius: 5, color: UIColor.black, opacity: 0.3, offset: CGSize.zero)
        LayerEffects.AddRoundedBorderToView(emailSignupButton, withRadius: 8)
        
        //add target
        emailSignupButton.addTarget(self, action: #selector(LoginOptions.segueToEmailSignup), for: .touchUpInside)
        
        //Add email login button
        emailLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emailLoginButton)
        
        //position email login button
        emailLoginButton.topAnchor.constraint(equalTo: emailSignupButton.bottomAnchor, constant: buttonsSeparation * self.view.frame.height).isActive = true
        emailLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        //Set up button looks
        emailLoginButton.setTitle("Already have an account? Log In", for: .normal)
        emailLoginButton.setTitleColor(UIColor.black, for: .normal)
        emailLoginButton.titleLabel!.font = Fonts.CollegeBoyWithSize(size: 20)
        LayerEffects.AddShadowToView(emailLoginButton.titleLabel!, withRadius: 2, color: UIColor.black, opacity: 0.3, offset: CGSize.zero)
        
        //Add target
        emailLoginButton.addTarget(self, action: #selector(LoginOptions.segueToEmail), for: .touchUpInside)
    }
    
    static func addRadialLayer(view : UIView){
        //Add the radialGradient Layer
        let radialGradient = LayerRadialGradient()
        radialGradient.frame = view.frame
        view.layer.insertSublayer(radialGradient, at: 0)
    }
    
    @IBAction func segueToEmailSignup(){
        self.performSegue(withIdentifier: "ToLoginEmailSignup", sender: self)
    }
    
    @IBAction func segueToEmail(){
        self.performSegue(withIdentifier: "ToLoginEmail", sender: self)
    }
    
    //Method for signing user in. See firebase authentication guides for detail
    @IBAction func signUpWithFacebook() {
        let loginManager = LoginManager()
        
        continueRotate = true
        let animationDuration = 0.3
        self.loadingCoin.isHidden = false
        UIView.animate(withDuration: animationDuration) {
            self.blurEffect.alpha = 0.8
            self.facebookButton.alpha = 0
            self.emailLoginButton.alpha = 0
            self.emailSignupButton.alpha = 0
        }
        self.rotateCoin()
        
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
                    
                    FirebaseManager.shared.setupUserData(user: result.user, email: result.user.email!, username: result.user.displayName!, controller: self)
                    //TODO: CREATE A PAGE FOR FACEBOOK USERS TO TYPE USER NAME
                    
                    //FirebaseManager.shared.fetchUser(withID: result.user.uid, controller: self)
                    
                })
            }
        }
    }
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}






















