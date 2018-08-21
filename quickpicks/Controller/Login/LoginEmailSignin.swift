//
//  LoginEmail.swift
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

class LoginEmailSignin: UIViewController, Promise {
    var container : UIView! = nil
    var containerRaised : Bool = false

    var loadingCoin : UIImageView!
    var viewContainer : LoginEmailSigninView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewContainer = LoginEmailSigninView()
        viewContainer.addTo(self)

        ViewContainer.setupRadialGradient(self.view)

        NotificationCenter.default.addObserver(self, selector: #selector(LoginEmailSignin.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginEmailSignin.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func resolve(result: Any) {
        print("resolved")
        self.performSegue(withIdentifier: SegueConstants.LOGINEMAILSIGNIN_PICKSCHOOSESPORTS, sender: self)
    }
    
    func reject(error: String) {
        print(error)
    }
    
    var continueRotate = false
    var blurEffect : UIVisualEffectView!
    
    @IBAction func signinFacebook(){
        print("clicked")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signin(){
        continueRotate = true
        let animationDuration = 0.3
        let email = viewContainer.emailTextField.textField.text!
        let password = viewContainer.passwordTextField.textField.text!
        
        LoginFirebase.signinUser(email: email, password: password, delegate: self)
        
        /*
        self.loadingCoin.isHidden = false
        UIView.animate(withDuration: animationDuration) {
            self.blurEffect.alpha = 0.8
            self.descriptionView.alpha = 0
            self.headerImage.alpha = 0
            self.emailTextField.alpha = 0
            self.passwordTextField.alpha = 0
            self.signinButton.alpha = 0
            self.signinWithFBButton.alpha = 0
        }
        */
      //  self.rotateCoin()
        /*
        FirebaseManager.shared.signinUser(withEmail: emailTextField.textField.text!, password: passwordTextField.textField.text!, controller: self)*/
    }
    
    func rotateCoin(){
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0, options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.loadingCoin.transform = self.loadingCoin.transform.rotated(by: 3.14 / 2.0)
        }, completion: {(_) in
            if(self.continueRotate){
                self.rotateCoin()
            }
        })
    }
    

    @objc func keyboardWillShow(_ sender : NSNotification){
        if(!self.containerRaised){
            containerRaised = true
            let animationCurve : NSNumber = sender.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
            let animationDuration : NSNumber = sender.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            let endFrame : CGRect = (sender.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            UIViewPropertyAnimator(duration: animationDuration.doubleValue, curve: UIViewAnimationCurve(rawValue: animationCurve.intValue)!) {
                self.view.center.y -= endFrame.size.height / 2.0
                self.viewContainer.headerImage.alpha = 0.0
                }.startAnimation()
        }
        
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification){
        self.containerRaised = false
        let animationCurve : NSNumber = sender.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let animationDuration : NSNumber = sender.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        UIViewPropertyAnimator(duration: animationDuration.doubleValue, curve: UIViewAnimationCurve(rawValue: animationCurve.intValue)!) {
            self.view.center.y = 0
            self.viewContainer.headerImage.alpha = 1.0
            }.startAnimation()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
