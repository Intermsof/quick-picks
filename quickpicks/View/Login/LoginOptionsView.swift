//
//  LoginOptions.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/18/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class LoginOptionsView : ViewContainer {
    //View related constants
    let BUTTON_WIDTH_PERCENTAGE : CGFloat = 0.715 //Percentage of the screen width to make buttons
    let FB_BUTTON_HEIGHT_TO_WIDTH_RATIO : CGFloat = 0.18 //Multiply this by the width to get the height
    let EMAIL_BUTTON_HEIGHT_TO_WIDTH_RATIO : CGFloat = 0.15 //Multiply this by the width to get the height
    let FACEBOOK_BUTTON_BELOW_CENTER_PERCENTAGE_OF_SCREEN_HEIGHT : CGFloat = 0.25 //Percentage of screen Height to offset top of button from parent centerY
    let PADDING : CGFloat = 15 //amount to use as padding
    
    let facebookButton = UIButton()
    let emailLoginButton = UIButton()
    let emailSignupButton = UIButton()
    
    
    override init(){
        super.init()
        include(facebookButton)
        include(emailSignupButton)
        include(emailLoginButton)
        
        setupFacebookButton()
        setupEmailSignupButton()
        setupEmailLoginButton()
    }

    
    func setupEmailLoginButton(){
        placeBelow(source: emailLoginButton, target: emailSignupButton, padding: PADDING)
        centerHorizontally(emailLoginButton)
        
        emailLoginButton.setTitle("Already have an account? Log In", for: .normal)
        emailLoginButton.setTitleColor(UIColor.black, for: .normal)
        emailLoginButton.titleLabel!.font = Fonts.CollegeBoyWithSize(size: 20)
        emailLoginButton.layer.shadowColor = UIColor.black.cgColor
        emailLoginButton.layer.shadowOpacity = 0.3
        emailLoginButton.layer.shadowOffset = CGSize.zero
        emailLoginButton.layer.shadowRadius = 2
    }
    
    //logic for setting up position and look of the facebook button
    func setupFacebookButton(){
        bindWidth(facebookButton, target: self, BUTTON_WIDTH_PERCENTAGE)
        setHeightToWidthRatio(facebookButton, FB_BUTTON_HEIGHT_TO_WIDTH_RATIO)
        centerHorizontally(facebookButton)
        //todo: move this button downwards
        centerVertically(facebookButton)
            
        //set up facebook Button looks
        facebookButton.backgroundColor = Colors.FBBlue
        facebookButton.setTitle("sign in with facebook", for: .normal)
        facebookButton.setTitleColor(UIColor.white, for: .normal)
        facebookButton.titleLabel!.font = Fonts.CollegeBoyWithSize(size: 27)
        facebookButton.layer.shadowColor = UIColor.black.cgColor
        facebookButton.layer.shadowOpacity = 0.3
        facebookButton.layer.shadowOffset = CGSize.zero
        facebookButton.layer.shadowRadius = 5
        facebookButton.layer.cornerRadius = 8
    }
    
    func setupEmailSignupButton(){
        bindWidth(emailSignupButton, target: self, BUTTON_WIDTH_PERCENTAGE)
        setHeightToWidthRatio(emailSignupButton, EMAIL_BUTTON_HEIGHT_TO_WIDTH_RATIO)
        centerHorizontally(emailSignupButton)
        
        placeBelow(source: emailSignupButton, target: facebookButton, padding: PADDING)
        
        emailSignupButton.backgroundColor = UIColor.black
        emailSignupButton.setTitle("sign up with email", for: .normal)
        emailSignupButton.setTitleColor(UIColor.white, for: .normal)
        emailSignupButton.titleLabel!.font = Fonts.CollegeBoyWithSize(size: 24)
        emailSignupButton.layer.shadowColor = UIColor.black.cgColor
        emailSignupButton.layer.shadowOpacity = 0.3
        emailSignupButton.layer.shadowOffset = CGSize.zero
        emailSignupButton.layer.shadowRadius = 5
        emailSignupButton.layer.cornerRadius = 8
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addTo(_ controller: UIViewController) {
        super.addTo(controller)

        emailLoginButton.addTarget(controller, action: #selector(LoginOptions.segueToEmail), for: .touchUpInside)
        emailSignupButton.addTarget(controller, action: #selector(LoginOptions.segueToEmailSignup), for: .touchUpInside)
        facebookButton.addTarget(controller, action: #selector(LoginOptions.signUpWithFacebook), for: .touchUpInside)
        
    }
    
}
