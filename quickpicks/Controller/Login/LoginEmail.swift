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

class LoginEmail: UIViewController, FirebaseCallable {
    static let headerWidthPercentage : CGFloat = 0.76 //Percentage of the screen width to make header
    static let descriptionWidthPercentage : CGFloat = 0.65 //Percentage of the screen width to make description
    static let headerHeightPercentageFromTop : CGFloat = 0.075 //Percentage of the screen height to offset the header from top of view
    static let headerFromDescriptionHeightPercentage : CGFloat = 0.01 //Percentage of the screen height to offset the description from header
    static let textFieldWidthPercentage : CGFloat = LoginEmail.headerWidthPercentage - 0.05
    static let textFieldSeparation : CGFloat = 20
    
    
    var container : UIView! = nil
    var containerRaised : Bool = false
    var headerImage : UIImageView!
    var descriptionView : UIImageView!
    var signinButton : UIButton!
    var signinWithFBButton : UIButton!
    var loadingCoin : UIImageView!
    var emailTextField : LoginTextField!
    var passwordTextField : LoginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = UIView()
        container.frame = self.view.frame
        self.view.addSubview(container)
        
        let images = LoginEmail.placeImagesIn(view: container)
        headerImage = images.0
        descriptionView = images.1
        LoginOptions.addRadialLayer(view: container)
        
        emailTextField = LoginTextField(fieldType: .email, validate: false)
        container.addSubview(emailTextField)
        
        emailTextField.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: LoginEmail.textFieldWidthPercentage).isActive = true
        emailTextField.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: LoginEmail.textFieldSeparation).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        passwordTextField = LoginTextField(fieldType: .password, validate: false)
        container.addSubview(passwordTextField)
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: LoginEmail.textFieldSeparation).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        //Create sign up button
        let buttons = LoginEmailSignup.createButtons(signupString: "sign in", fbString: "sign in with facebook")
        
        signinButton = buttons.0
        container.addSubview(signinButton)
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        signinButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: LoginEmailSignup.signupButtonWidthPercentage).isActive = true
        signinButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: LoginEmail.textFieldSeparation).isActive = true
        signinButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        signinButton.addTarget(self, action: #selector(LoginEmail.signin), for: .touchUpInside)
        
        signinWithFBButton = buttons.1
        container.addSubview(signinWithFBButton)
        signinWithFBButton.translatesAutoresizingMaskIntoConstraints = false
        signinWithFBButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        signinWithFBButton.topAnchor.constraint(equalTo: signinButton.bottomAnchor, constant: LoginEmail.textFieldSeparation).isActive = true
        
        signinWithFBButton.addTarget(self, action: #selector(LoginEmail.signinFacebook), for: .touchUpInside)
        
        blurEffect = LoginEmailSignup.createBlurEffect(container: container)
        loadingCoin = LoginEmailSignup.createLoadingCoin(container: container)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginEmail.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginEmail.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        
        self.rotateCoin()
        
        FirebaseManager.shared.signinUser(withEmail: emailTextField.textField.text!, password: passwordTextField.textField.text!, controller: self)
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
    
    func notifyFailure() {
        
    }
    
    func notifySuccess() {
        continueRotate = false
        performSegue(withIdentifier: "ToPicksFromLoginEmail", sender: self)
    }
    
    @objc func keyboardWillShow(_ sender : NSNotification){
        if(!self.containerRaised){
            containerRaised = true
            let animationCurve : NSNumber = sender.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
            let animationDuration : NSNumber = sender.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            let endFrame : CGRect = (sender.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            UIViewPropertyAnimator(duration: animationDuration.doubleValue, curve: UIViewAnimationCurve(rawValue: animationCurve.intValue)!) {
                self.container.center.y -= endFrame.size.height / 4.0
                self.headerImage.alpha = 0.0
                }.startAnimation()
        }
        
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification){
        self.containerRaised = false
        let animationCurve : NSNumber = sender.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let animationDuration : NSNumber = sender.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        UIViewPropertyAnimator(duration: animationDuration.doubleValue, curve: UIViewAnimationCurve(rawValue: animationCurve.intValue)!) {
            self.container.center.y = self.view.center.y
            self.headerImage.alpha = 1.0
            }.startAnimation()
    }
    
    
    
    //This function adds the header and description images into the loginemail and loginemailsignup pages
    //Use this function by passing in the root view of the viewcontroller to this function
    //Returns the Description ImageView to allow positioning textfields underneath it
    static func placeImagesIn(view : UIView) -> (UIImageView, UIImageView) {
        //Rescale the headerImage
        var headerImage = #imageLiteral(resourceName: "QPHeader")
        let headerWidth = LoginEmail.headerWidthPercentage * view.frame.width
        let headerHeight = (headerImage.size.height / headerImage.size.width) * headerWidth
        UIGraphicsBeginImageContextWithOptions(CGSize(width: headerWidth, height: headerHeight), false, 2.0)
        headerImage.draw(in: CGRect(x: 0, y: 0, width: headerWidth, height: headerHeight))
        headerImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //Create a UIImageview out of the headerImage and add it to the view
        let headerImageView = UIImageView(image: headerImage)
        view.addSubview(headerImageView)
        //Position the header
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: LoginEmail.headerHeightPercentageFromTop * view.frame.height).isActive = true
        
        //Rescale the description Image
        var descriptionImage = #imageLiteral(resourceName: "QPDescription")
        let descriptionWidth = LoginEmail.descriptionWidthPercentage * view.frame.width
        let descriptionHeight = (descriptionImage.size.height / descriptionImage.size.width) * headerWidth
        UIGraphicsBeginImageContextWithOptions(CGSize(width: descriptionWidth, height: descriptionHeight), false, 2.0)
        descriptionImage.draw(in: CGRect(x:0,y:0,width: descriptionWidth, height: descriptionHeight))
        descriptionImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //Create a UIImageView out of the description Image and add it to the view
        let descriptionImageView = UIImageView(image: descriptionImage)
        view.addSubview(descriptionImageView)
        //position the description
        descriptionImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: LoginEmail.headerFromDescriptionHeightPercentage * view.frame.height).isActive = true
        descriptionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return (headerImageView,descriptionImageView)
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
