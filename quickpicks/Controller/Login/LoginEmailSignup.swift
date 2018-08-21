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

class LoginEmailSignup: UIViewController, Promise{
    func resolve(result: Any) {
        print("resolved")
    }
    
    func reject(error: String) {
        print("rejected")
        print(error)
    }
    
    
    var container : LoginEmailSignupView! = nil
    var containerRaised : Bool = false
    
    var headerImage : UIImageView!
    var descriptionImage : UIImageView!
    
    var email : LoginTextField!
    var password : LoginTextField!
    var passwordRetype : LoginTextField!
    var username : LoginTextField!
    
    var blurEffect : UIVisualEffectView!
    var wrapper : UIView!
    
    var signupButton : UIButton!
    
    var fbLoginButton : UIButton!
    
    static let signupButtonWidthPercentage : CGFloat = 0.4 //Percentage of full screen width of sign up button
    override func viewDidLoad() {
        print("view did load called")
        super.viewDidLoad()

        container = LoginEmailSignupView()
        container.addTo(self)
        ViewContainer.setupRadialGradient(self.view)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginEmailSignup.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginEmailSignup.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    var loadingCoin : UIImageView!
    @objc func keyboardWillShow(_ sender : NSNotification){
        if(!self.containerRaised){
            containerRaised = true
            let animationCurve : NSNumber = sender.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
            let animationDuration : NSNumber = sender.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            let endFrame : CGRect = (sender.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            UIViewPropertyAnimator(duration: animationDuration.doubleValue, curve: UIViewAnimationCurve(rawValue: animationCurve.intValue)!) {

                self.view.center.y -= endFrame.size.height
                self.container.headerImage.alpha = 0.0
                self.container.descriptionImage.alpha = 0.0
            }.startAnimation()
        }
        
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification){
        self.containerRaised = false
        let animationCurve : NSNumber = sender.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let animationDuration : NSNumber = sender.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        UIViewPropertyAnimator(duration: animationDuration.doubleValue, curve: UIViewAnimationCurve(rawValue: animationCurve.intValue)!) {
            self.view.center.y = 0
            self.container.headerImage.alpha = 1.0
            self.container.descriptionImage.alpha = 1.0
        }.startAnimation()
    }
    
    @IBAction func signupUser(){
        print("sign up user fired")
        let email = container.emailField.textField.text!
        let username = container.usernameField.textField.text!
        let password = container.passwordField.textField.text!
        
        LoginFirebase.signupUser(email: email, username: username, password: password , delegate: self)
        
        
        
//        LoginFirebase.signinUser(email: "testing123@gmail.com", password: "someshit", delegate: self)
//
//        guard !email.hasError() && !username.hasError() && !password.hasError() && !passwordRetype.hasError() else {
//            if(email.hasError()){
//                email.shakeAnimation()
//            }
//            if(password.hasError()){
//                password.shakeAnimation()
//            }
//            if(passwordRetype.hasError()){
//                passwordRetype.shakeAnimation()
//            }
//            if(username.hasError()){
//                username.shakeAnimation()
//            }
//            return
//        }
//
//        self.email.textField.resignFirstResponder()
//        self.password.textField.resignFirstResponder()
//        self.passwordRetype.textField.resignFirstResponder()
//        self.username.textField.resignFirstResponder()
/*
        continueRotate = true
        let animationDuration = 0.3
        self.loadingCoin.isHidden = false
        UIView.animate(withDuration: animationDuration) {
            self.blurEffect.alpha = 0.8
            self.descriptionImage.alpha = 0
            self.headerImage.alpha = 0
            self.username.alpha = 0
            self.email.alpha = 0
            self.password.alpha = 0
            self.passwordRetype.alpha = 0
            self.signupButton.alpha = 0
            self.fbLoginButton.alpha = 0
        }
        
        self.rotateCoin()
     */
        /*
        FirebaseManager.shared.createUser(withEmail: email.textField.text!, password: password.textField.text!, username: username.textField.text!, controller: self)
 */
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
    
    func notifyFailure(){
        print("we just got fucked in notify failure")
    }

    let toPicksSegueName = "ToPicksFromLoginEmailSignup"
    func notifySuccess(){
        self.continueRotate = false
        self.performSegue(withIdentifier: toPicksSegueName, sender: self)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
