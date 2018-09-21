//
//  LoginEmailSignup.swift
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

class LoginEmailSignup: UIViewController, Promise, LoginEmailSignupDelegate{
    func resolve(result: Any) {
        print("resolved")
    }
    
    func reject(error: String) {
        print("rejected")
        print(error)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var viewContainer : LoginEmailSignupView!
    var containerRaised : Bool = false

    override func viewDidLoad() {
        print("view did load called")
        super.viewDidLoad()
        self.navigationController!.setNeedsStatusBarAppearanceUpdate()

        viewContainer = LoginEmailSignupView(delegate: self)
        viewContainer.addTo(self)
        ViewContainer.setupRadialGradient(self.view)
        
    }
    
    static func createButtons(signupString : String, fbString : String)->(UIButton, UIButton){
        let signupButton = UIButton()
        signupButton.backgroundColor = UIColor.black
        signupButton.layer.cornerRadius = 8.0
        let signupAttributedTitle =  NSAttributedString(string: signupString, attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 22),NSAttributedStringKey.kern : 2.0, NSAttributedStringKey.foregroundColor : UIColor.white])
        signupButton.setAttributedTitle(signupAttributedTitle, for: .normal)
        
        
        //position email login button
        let fbLoginButton = UIButton()
        //Set up button looks
        let fbLoginButtonString = NSAttributedString(string: fbString, attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 22), NSAttributedStringKey.foregroundColor : Colors.FBBlue, NSAttributedStringKey.kern : 1.5, NSAttributedStringKey.underlineStyle : 1, NSAttributedStringKey.underlineColor : Colors.FBBlue])
        fbLoginButton.setAttributedTitle(fbLoginButtonString, for: .normal)
        
       /* LayerEffects.AddShadowToView(fbLoginButton.titleLabel!, withRadius: 2, color: Colors.FBBlue, opacity: 0.3, offset: CGSize.zero)*/
        
        return (signupButton, fbLoginButton)
    }
    

    @IBAction func goBack(){
        self.dismiss(animated: false, completion: nil)
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func signupUser(){
        print("sign up user fired")
        let email = viewContainer.emailField.textField.text!
        let username = "\(viewContainer.firstNameField.textField.text!) \(viewContainer.lastNameField.textField.text!.first!)"
        let password = viewContainer.passwordField.textField.text!
        
        LoginFirebase.signupUser(email: email, username: username, password: password , delegate: self)
    }
    
    /*
     var loadingCoin : UIImageView!
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
     
     static func createBlurEffect(container: UIView) -> UIVisualEffectView {
     let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
     
     blurEffect.frame = container.frame
     blurEffect.alpha = 0.0
     container.addSubview(blurEffect)
     
     return blurEffect
     }
     
     static func createLoadingCoin(container : UIView) -> UIImageView{
     let loadingCoin = UIImageView(image: #imageLiteral(resourceName: "QPCoin"))
     container.addSubview(loadingCoin)
     loadingCoin.translatesAutoresizingMaskIntoConstraints = false
     loadingCoin.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
     loadingCoin.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
     loadingCoin.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.2).isActive = true
     loadingCoin.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.2).isActive = true
     loadingCoin.isHidden = true
     return loadingCoin
     }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear called")
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
