//
//  LoginTextField.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/14/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

/*
 -------------------------- DESCRIPTION OF CLASS FUNCTIONALITY ---------------------------------
 
 An UIView that wraps a UITextField and, optionally, an error message.
 
 Must set the size and position manually with anchors when using this class.
 
 -------------------------- DOCUMENTATION UPDATED 06/12/18 -------------------------------------
 */

import UIKit

class LoginTextField : UIView, UITextFieldDelegate {
    enum FieldType {
        case email
        case password
        case passwordRetype
        case username
    }
    
    let textField : _LoginTextField
    var whileEdittingErrorLabel : UILabel? = nil
    var completionErrorLabel : UILabel? = nil

    //ratio of height to width for a textfield in login pages
    static let textFieldHeightToWidthRatio : CGFloat = 0.15
    //ratio of height to width for a textfield and error message
    static let textFieldAndErrorMessageHeightToWidthRatio : CGFloat = 0.2
    static let errorMessageOffset : CGFloat = 10 //Vertical separation of errorMessage from textfield
    static let staticAnimationDuration = 0.3 //Duration for animating appearance of error message
    static let errorMessageAttributes : [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 14),
                                                                         NSAttributedStringKey.kern : 1.5,
                                                                         NSAttributedStringKey.foregroundColor : Colors.QPRed]
    
    
    //Variables for setting up placeholder and user typed text
    let textFont : UIFont
    let textColor : UIColor
    let textKerning : NSNumber
    func setupTextfield(){
        textField.delegate = self
        textField.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        textField.textColor = UIColor.white
        
        //Set a default placeholder for. Call "setPlaceHolder" to change
        setPlaceholder("default placeholder")
        
        //Styling for user typed text
        textField.defaultTextAttributes = [NSAttributedStringKey.font.rawValue : textFont,
                                           NSAttributedStringKey.foregroundColor.rawValue : textColor,
                                           NSAttributedStringKey.kern.rawValue : textKerning]
        
        //Border
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 6.0
        
        //Keyboard traits
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.clearButtonMode = .whileEditing
        
        //anchor textfield to its wrapping parent
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
    }
    
    init(){
        textField = _LoginTextField()
        //Variables for setting up placeholder and user typed text
        textFont = Fonts.CollegeBoyWithSize(size: 18)
        textColor = UIColor.white
        textKerning = NSNumber(value: 1.0)
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupTextfield()
    }
    
    func setPlaceholder(_ placeholder : String){
        //Styling for placeholder text
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedStringKey.font : textFont,
            NSAttributedStringKey.foregroundColor : textColor,
            NSAttributedStringKey.kern : textKerning])
    }

    

    /*
    static let usernameErrorMessage = "username must be 6 to 15 letters long"
    static let emailErrorMessage = "this is not a valid email format"
    static let passwordErrorMessage = "password must be 7 or more characters long"
    static let passwordRetypeErrorMessage = "passwords do not match"
    func getErrorMessage() -> String{
        switch fieldType {
        case .email:
            return LoginTextField.emailErrorMessage
        case .password:
            return LoginTextField.passwordErrorMessage
        case .username:
            return LoginTextField.usernameErrorMessage
        case .passwordRetype:
            return LoginTextField.passwordRetypeErrorMessage
        }
    }
    
    func completionValidate(){
        if(fieldType == .username){
            //FirebaseManager.shared.checkAvailable(username: self)
        }
        else if(fieldType == .email){
            //FirebaseManager.shared.checkAvailable(email: self)
        }
    }
    
    func whileEditingValidate(text : String?) -> Bool{
        if let text = text {
            switch fieldType {
            case .email:
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailTest.evaluate(with: text)
            case .password:
                return text.count >= 7
            case .username:
                return text.count >= 6  && text.count <= 15
            case .passwordRetype:
                //REMEMBER TO SET THE MAINPASSWORD FIELD IN WHEREEVER YOU ARE USING THIS
                return mainPassword!.textField.text == text
            }
        }
        
        return false
    }
    */
    func shakeAnimation(){
        let midX = textField.center.x
        let midY = textField.center.y
        let shakeAmount : CGFloat = 5
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: midX - shakeAmount, y: midY)
        animation.toValue = CGPoint(x: midX + shakeAmount, y: midY)
        textField.layer.add(animation, forKey: "position")
    }
    

    //A method that determines whether the current text is valid, and whether it needs to animate in a error message
    //or make the error message disappear
//    @objc func textFieldDidChange(_ textField: _LoginTextField) throws {
//        //If user of this class asked for no validation, exit immediately
//        if(!validate){
//            return
//        }
//
//        guard let text = textField.text else {
//            return
//        }
//
//        let textValid : Bool
//        //If there's no text, we set it to true because we don't want to show an error message if no text available
//        if(text.count == 0){
//            textValid = true
//        }else{
//            textValid = whileEditingValidate(text: text)
//        }
//        let needsDisplayErrorMessage = !textValid && !self.wasInErrorState
//        let needsHideErrorMessage = textValid && (self.wasInErrorState || self.hadCompletionError)
//
//        if(needsDisplayErrorMessage){
//            addWhileEdittingErrorMessage()
//        }else if(needsHideErrorMessage){
//            hideWhileEdittingErrorMessage()
//        }
//    }
    
//    func hideWhileEdittingErrorMessage(){
//        print("hding while edditng")
//
//        UIView.animate(withDuration: LoginTextField.staticAnimationDuration, animations: {
//            self.whileEdittingErrorLabel!.alpha = 0.0
//        }, completion:{(completed) in
//            if(completed){
//                self.heightWithErrorConstraint.isActive = false
//                self.heightConstraint.isActive = true
//                self.layoutIfNeeded()
//                self.whileEdittingErrorLabel!.isHidden = true
//
//            }
//        })
//
//        self.wasInErrorState = false
//        self.hadCompletionError = false
//    }
    
//    func addWhileEdittingErrorMessage(){
//        print("add whil eddintg")
//                if(self.hadCompletionError){
//            UIView.animate(withDuration: LoginTextField.staticAnimationDuration, animations:  {
//                self.whileEdittingErrorLabel!.isHidden = false
//                self.whileEdittingErrorLabel!.alpha = 1.0
//                self.completionErrorLabel!.alpha = 0.0
//                self.completionErrorLabel!.isHidden = true
//            })
//        }
//        else{
//            UIView.animate(withDuration: LoginTextField.staticAnimationDuration, animations:  {
//                self.heightConstraint.isActive = false
//                self.heightWithErrorConstraint.isActive = true
//                self.layoutIfNeeded()
//                self.whileEdittingErrorLabel!.isHidden = false
//                self.whileEdittingErrorLabel!.alpha = 1.0
//            })
//        }
//        self.wasInErrorState = true
//        self.hadCompletionError = false
//
//    }
//
//    func addCompletionErrorMessage(){
//        self.hadCompletionError = true
//        //self.completionErrorLabel!.isHidden = false
//        print("add completion error messag")
//        UIView.animate(withDuration: LoginTextField.staticAnimationDuration, animations:  {
//            self.heightConstraint.isActive = false
//            self.heightWithErrorConstraint.isActive = true
//            self.layoutIfNeeded()
//            self.completionErrorLabel!.alpha = 1.0
//            self.completionErrorLabel!.isHidden = false
//            self.completionErrorLabel!.setNeedsDisplay()
//
//        })
//
//        print(self.completionErrorLabel!.alpha)
//        print(self.completionErrorLabel!.isHidden)
//
//    }
//

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class _LoginTextField : UITextField{
        static let textInsetAmount : CGFloat = 10.0
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: _LoginTextField.textInsetAmount, dy: _LoginTextField.textInsetAmount)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: _LoginTextField.textInsetAmount, dy: _LoginTextField.textInsetAmount)
        }
    }
    

}
