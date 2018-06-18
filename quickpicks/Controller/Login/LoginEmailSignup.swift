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

class LoginEmailSignup: UIViewController {
    var container : UIView! = nil
    var containerRaised : Bool = false
    
    var headerImage : UIImageView!
    var descriptionImage : UIImageView!
    
    let signupButtonWidthPercentage : CGFloat = 0.4 //Percentage of full screen width of sign up button
    override func viewDidLoad() {
        super.viewDidLoad()

        container = UIView(frame: self.view.frame)
        self.view.addSubview(container)
        
        // Do any additional setup after loading the view.
        let images = LoginEmail.placeImagesIn(view: container)

        headerImage = images.0
        descriptionImage = images.1
        
        LoginOptions.addRadialLayer(view: container)
        
        let username = LoginTextField.buildLoginTextFieldWith(type: .username, validate: true)
        
        container.addSubview(username)
        username.topAnchor.constraint(equalTo: descriptionImage.bottomAnchor, constant: LoginEmail.textFieldSeparation).isActive = true
        username.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: LoginEmail.textFieldWidthPercentage).isActive = true
        username.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
 
        let email = LoginTextField.buildLoginTextFieldWith(type: .email, validate: true)
        container.addSubview(email)
        email.topAnchor.constraint(equalTo: username.bottomAnchor, constant: LoginEmail.textFieldSeparation).isActive = true
        email.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: LoginEmail.textFieldWidthPercentage).isActive = true
        email.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        let password = LoginTextField.buildLoginTextFieldWith(type: .password, validate: true)
        container.addSubview(password)
        password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: LoginEmail.textFieldSeparation).isActive = true
        password.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: LoginEmail.textFieldWidthPercentage).isActive = true
        password.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        let passwordRetype = LoginTextField.buildLoginTextFieldWith(type: .passwordRetype, validate: true)
        container.addSubview(passwordRetype)
        passwordRetype.topAnchor.constraint(equalTo: password.bottomAnchor, constant: LoginEmail.textFieldSeparation).isActive = true
        passwordRetype.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: LoginEmail.textFieldWidthPercentage).isActive = true
        passwordRetype.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        
        //GET THE ACTUAL TEXTFIELD FROM WRAPPER. ASSUMES TEXTFIELD IS SUBVIEWS[0]. IF YOU CHANGE THE FACTORY METHOD SUCH THAT THIS IS NO LONGER TRUE, BE SURE TO UPDATE THIS PART
        let usernameField = username.subviews[0] as! LoginTextField
        let emailField = email.subviews[0] as! LoginTextField
        let passwordField = password.subviews[0] as! LoginTextField
        let passwordRetypeField = passwordRetype.subviews[0] as! LoginTextField
        
        //HERE WE MUST MANUALLY SET THE VALIDATION CLOSURE FOR PASSWORDRETYPE BECAUSE IT NEEDS A REFERENCE TO THE MAIN PASSWORD
        passwordRetypeField.validation = {(text) in
            if let text = text {
                return text == passwordField.text
            }
            return false
        }
        
        usernameField.nextField = emailField
        emailField.nextField = passwordField
        passwordField.nextField = passwordRetypeField
        
        //Create sign up button
        let signupButton = UIButton()
        self.container.addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: signupButtonWidthPercentage).isActive = true
        signupButton.heightAnchor.constraint(equalTo: username.heightAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: passwordRetype.bottomAnchor, constant: LoginEmail.textFieldSeparation * 1.5).isActive = true
        signupButton.backgroundColor = UIColor.black
        signupButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
        signupButton.layer.cornerRadius = 8.0
        let signupAttributedTitle =  NSAttributedString(string: "sign up", attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 22),NSAttributedStringKey.kern : 2.0, NSAttributedStringKey.foregroundColor : UIColor.white])
        signupButton.setAttributedTitle(signupAttributedTitle, for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginEmailSignup.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginEmailSignup.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender : NSNotification){
        if(!self.containerRaised){
            containerRaised = true
            let animationCurve : NSNumber = sender.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
            let animationDuration : NSNumber = sender.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            let endFrame : CGRect = (sender.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            UIViewPropertyAnimator(duration: animationDuration.doubleValue, curve: UIViewAnimationCurve(rawValue: animationCurve.intValue)!) {

                self.container.center.y -= endFrame.size.height
                self.headerImage.alpha = 0.0
                self.descriptionImage.alpha = 0.0
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
            self.descriptionImage.alpha = 1.0
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
