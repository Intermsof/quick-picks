//
//  LoginEmailSignupView.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/19/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class LoginEmailSignupView : ViewContainer {
    let TEXTFIELD_PADDING : CGFloat
    let TEXTFIELD_WIDTH_PERCENTAGE : CGFloat
    let TEXTFIELD_HEIGHT : CGFloat
    let emailField : LoginTextField
    let firstNameField : LoginTextField
    let lastNameField : LoginTextField
    let passwordField : LoginTextField
    let passwordRetypeField = LoginTextField(placeHolder: "retype password")
    let facebookSignupButton = UIButton()
    let signupButton = UIButton()
    let toolbar = UIToolbar()
    let topbar = UIView()
    let delegate : LoginEmailSignupDelegate
    
    init(delegate : LoginEmailSignupDelegate) {
        self.delegate = delegate
        TEXTFIELD_PADDING  = 5
        TEXTFIELD_WIDTH_PERCENTAGE = 0.9
        TEXTFIELD_HEIGHT = 45
        emailField = LoginTextField(placeHolder: "email",
                                    validator: Validators.isValidEmail,
                                    errorMessage: "Please enter a valid email address",
                                    height: TEXTFIELD_HEIGHT,
                                    completionValidator: Validators.signUpEmailCompletion,
                                    completionErrorMessage: "Sorry, this email is taken.")
        firstNameField = LoginTextField(placeHolder: "first name",
                                        validator: Validators.isValidFirstname,
                                        errorMessage: "First names must be at least 3 letters long",
                                        height: TEXTFIELD_HEIGHT)
        lastNameField = LoginTextField(placeHolder: "last name",
                                       validator: Validators.isValidLastName,
                                       errorMessage: "Last names must be at least 2 letters long",
                                       height: TEXTFIELD_HEIGHT)
        passwordField = LoginTextField(placeHolder: "password",
                                       validator: Validators.isValidPassword,
                                       errorMessage: "Passwords must be 7 or more letters long",
                                       height: TEXTFIELD_HEIGHT)
        super.init()
        
        include(topbar)
        include(firstNameField)
        include(lastNameField)
        include(emailField)
        include(passwordField)
        include(passwordRetypeField)
        include(signupButton)
        
        setupTopbar()
        setupFirstNameField()
        setupLastNameField()
        setupEmailField()
        setupPasswordField()
        setupPasswordRetypeField()
        setupSignupButton()
        setupToolbar()

    }
    @IBAction func goBack(){
        delegate.goBack()
    }
    func setupTopbar(){
        
        topbar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        topbar.backgroundColor = UIColor.black
        
        //Setup backbutton within topbar
        let backButton = UIImageView(image: #imageLiteral(resourceName: "back"))
        topbar.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        backButton.centerYAnchor.constraint(equalTo: topbar.centerYAnchor).isActive = true
        bindLeft(backButton, target: topbar, 20)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.goBack))
        tapRecognizer.numberOfTapsRequired = 1
        backButton.addGestureRecognizer(tapRecognizer)
        backButton.isUserInteractionEnabled = true
        
        
        let signUpLabel = UILabel()
        signUpLabel.attributedText = NSAttributedString(string: "sign up", attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 30), NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.kern: 2.0])
        topbar.addSubview(signUpLabel)
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        placeRight(source: signUpLabel, target: backButton, padding: 35)
        signUpLabel.centerYAnchor.constraint(equalTo: topbar.centerYAnchor).isActive = true
        
        bindWidth(topbar, target: self, 1.0)
        bindTop(topbar, target: self, 0)
    }
    
    func setupToolbar(){
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.dismiss))
        toolbar.setItems([flexSpace, doneButton], animated: false)
        toolbar.sizeToFit()
        
        firstNameField.textField.inputAccessoryView = toolbar
        lastNameField.textField.inputAccessoryView = toolbar
        emailField.textField.inputAccessoryView = toolbar
        passwordField.textField.inputAccessoryView = toolbar
        passwordRetypeField.textField.inputAccessoryView = toolbar
    }
    
    @IBAction func dismiss(){
        self.endEditing(true)
    }
    
    override func addTo(_ controller: UIViewController) {
        super.addTo(controller)
        
        signupButton.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(LoginEmailSignup.signupUser)))
    }
    
    func setupSignupButton(){
        bindWidth(signupButton, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
        placeBelow(source: signupButton, target: passwordRetypeField, padding: TEXTFIELD_PADDING)
        centerHorizontally(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
    
    func setupFirstNameField(){
//        bindWidth(usernameField, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
//        bindTop(usernameField, target: self, TEXTFIELD_PADDING)
//        centerHorizontally(usernameField)
        centerHorizontally(firstNameField)
        placeBelow(source: firstNameField, target: topbar, padding: 30)
        bindWidth(firstNameField, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
    }
    
    func setupLastNameField(){
        centerHorizontally(lastNameField)
        placeBelow(source: lastNameField, target: firstNameField, padding: TEXTFIELD_PADDING)
        bindWidth(lastNameField, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
    }
    
    func setupEmailField(){
        bindWidth(emailField, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
        centerHorizontally(emailField)
        placeBelow(source: emailField, target: lastNameField, padding: TEXTFIELD_PADDING)
        emailField.textField.keyboardType = .emailAddress
    }
    
    func setupPasswordField(){
        bindWidth(passwordField, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
        centerHorizontally(passwordField)
        placeBelow(source: passwordField, target: emailField, padding: TEXTFIELD_PADDING)
        passwordField.textField.isSecureTextEntry = true
    }
    
    func setupPasswordRetypeField(){
        bindWidth(passwordRetypeField, target: self, TEXTFIELD_WIDTH_PERCENTAGE)
        passwordRetypeField.heightAnchor.constraint(equalToConstant: TEXTFIELD_HEIGHT).isActive = true
        passwordField.textField.isSecureTextEntry = true
        centerHorizontally(passwordRetypeField)
        placeBelow(source: passwordRetypeField, target: passwordField, padding: TEXTFIELD_PADDING)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
