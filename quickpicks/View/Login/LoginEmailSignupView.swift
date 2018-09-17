//
//  LoginEmailSignupView.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/19/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class LoginEmailSignupView : LoginEmailBase {
    
    let emailField = LoginTextField(placeHolder: "Email", validator: Validators.isValidEmail, errorMessage: "please enter a valid email address", height: LoginEmailBase.TEXTFIELD_HEIGHT)
    let usernameField = LoginTextField(placeHolder: "Username", validator: Validators.isValidUserName,errorMessage: "username must be 6 or more letters long", height: LoginEmailBase.TEXTFIELD_HEIGHT)
    let passwordField = LoginTextField(placeHolder: "Password", validator: Validators.isValidPassword, errorMessage: "passwords must be 7 or more letters long", height: LoginEmailBase.TEXTFIELD_HEIGHT)
    let passwordRetypeField = LoginTextField(placeHolder: "Retype password")
    let facebookSignupButton = UIButton()
    let signupButton = UIButton()
    
    override init() {
        super.init()
        include(emailField)
        include(usernameField)
        include(passwordField)
        include(passwordRetypeField)
        include(signupButton)
        include(facebookSignupButton)
        
        setupUsernameField()
        setupEmailField()
        setupPasswordField()
        setupPasswordRetypeField()
        setupSignupButton()
        setupSignupWithFacebookInsteadButton()
    }
    
    override func addTo(_ controller: UIViewController) {
        super.addTo(controller)
        
        signupButton.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(LoginEmailSignup.signupUser)))
        
        facebookSignupButton.addTarget(controller, action: #selector(LoginEmailSignup.signUpWithFacebook), for: .touchUpInside)
    }
    
    func setupSignupButton(){
        bindWidth(signupButton, target: self, SIGNUP_BUTTON_WIDTH_PERCENTAGE)
        placeBelow(source: signupButton, target: passwordRetypeField, padding: TEXTFIELD_PADDING)
        centerHorizontally(signupButton)
        signupButton.backgroundColor = UIColor.black
        signupButton.layer.cornerRadius = 8.0
        let signupAttributedTitle =  NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 20),NSAttributedStringKey.kern : 2.0, NSAttributedStringKey.foregroundColor : UIColor.white])
        signupButton.setAttributedTitle(signupAttributedTitle, for: .normal)
    }
    
    func setupSignupWithFacebookInsteadButton(){
        placeBelow(source: facebookSignupButton, target: signupButton, padding: TEXTFIELD_PADDING)
        centerHorizontally(facebookSignupButton)
        let fbLoginButtonString = NSAttributedString(string: "sign up with facebook instead", attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 22), NSAttributedStringKey.foregroundColor : Colors.FBBlue, NSAttributedStringKey.kern : 1.5, NSAttributedStringKey.underlineStyle : 1, NSAttributedStringKey.underlineColor : Colors.FBBlue])
        facebookSignupButton.setAttributedTitle(fbLoginButtonString, for: .normal)
        facebookSignupButton.layer.shadowColor = Colors.FBBlue.cgColor
        facebookSignupButton.layer.shadowOpacity = 0.3
        facebookSignupButton.layer.shadowOffset = CGSize.zero
        facebookSignupButton.layer.shadowRadius = 2
    }
    
    func setupUsernameField(){
        bindWidth(usernameField, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
        
        centerHorizontally(usernameField)
        placeBelow(source: usernameField, target: descriptionImage, padding: TEXTFIELD_PADDING)
    }
    
    func setupEmailField(){
        bindWidth(emailField, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
        
        centerHorizontally(emailField)
        placeBelow(source: emailField, target: usernameField, padding: TEXTFIELD_PADDING)
    }
    
    func setupPasswordField(){
        bindWidth(passwordField, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
        centerHorizontally(passwordField)
        placeBelow(source: passwordField, target: emailField, padding: TEXTFIELD_PADDING)
    }
    
    func setupPasswordRetypeField(){
        bindWidth(passwordRetypeField, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
        passwordRetypeField.heightAnchor.constraint(equalToConstant: LoginEmailBase.TEXTFIELD_HEIGHT).isActive = true
        centerHorizontally(passwordRetypeField)
        placeBelow(source: passwordRetypeField, target: passwordField, padding: TEXTFIELD_PADDING)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
