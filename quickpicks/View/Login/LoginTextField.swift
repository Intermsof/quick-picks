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

class LoginTextField : UITextField, UITextFieldDelegate {
    static let textInsetAmount : CGFloat = 10.0
    static let textFieldHeightToWidthRatio : CGFloat = 0.15 //ratio of height to width for a textfield in login pages
    static let textFieldAndErrorMessageHeightToWidthRatio : CGFloat = 0.2 //ratio of height to width for a textfield and error message. This is only for the wrapping UIView
    static let errorMessageAttributes : [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 14),
                                                                         NSAttributedStringKey.kern : 1.5,
                                                                         NSAttributedStringKey.foregroundColor : Colors.QPRed]
    static let errorMessageOffset : CGFloat = 10 //Vertical separation of errorMessage from textfield
    
    static let emailPlaceholder = "email"
    static let passwordPlaceholder = "password"
    static let passwordRetypePlaceholder = "re-type password"
    static let usernamePlaceholder = "username"
    
    static let usernameErrorMessage = "username must be 6 to 15 letters long"
    static let emailErrorMessage = "this is not a valid email format"
    static let passwordErrorMessage = "password must be 7 or more characters long"
    static let passwordRetypeErrorMessage = "passwords do not match"
    
    static let staticAnimationDuration = 0.3 //Duration for animating appearance of error message
    
    var validation : ((String?) -> Bool)?
    let errorMessage : String?
    var wasInErrorState = false //A field indicating whether the previous change had an error. This is used to help animate the appearance and dissapearance of the error message
    var wrapperHeightConstraint : NSLayoutConstraint! = nil //Set this in the factory method
    var wrapperWithErrorHeightConstraint : NSLayoutConstraint! = nil //Set this in the factory method
    var nextField : LoginTextField? = nil //The next textfield to transfer to once return is pressed
    var completionValidation : ((String?) -> Void)? = nil
    
    var mainPassword : LoginTextField? = nil
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let completionValidation = completionValidation {
            completionValidation(self.text)
        }
        if let nextField = nextField {
            if(!wasInErrorState && self.text?.count != 0){
                nextField.becomeFirstResponder()
            }else{
                let midX = self.center.x
                let midY = self.center.y
                let shakeAmount : CGFloat = 5
                
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.06
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = CGPoint(x: midX - shakeAmount, y: midY)
                animation.toValue = CGPoint(x: midX + shakeAmount, y: midY)
                layer.add(animation, forKey: "position")
            }
        }
        else{
            self.resignFirstResponder()
        }
        print("textfield return called")
        return true
    }
    
    private init(frame: CGRect, placeHolder : String, validation : ((String?) -> Bool)? = nil, errorMessage : String? = nil){
        self.validation = validation
        self.errorMessage = errorMessage
        super.init(frame: frame)
        //set delegate
        self.delegate = self
        //basic look
        self.backgroundColor = UIColor.lightGray
        self.textColor = UIColor.white
        
        //Text attributes for placeholder and user typed text
        let textFont = Fonts.CollegeBoyWithSize(size: 18)
        let textColor = UIColor.white
        let textKerning = NSNumber(value: 1.0)
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [
            NSAttributedStringKey.font : textFont,
            NSAttributedStringKey.foregroundColor : textColor,
            NSAttributedStringKey.kern : textKerning])
        
        self.defaultTextAttributes = [NSAttributedStringKey.font.rawValue : textFont,
                                           NSAttributedStringKey.foregroundColor.rawValue : textColor,
                                           NSAttributedStringKey.kern.rawValue : textKerning]
        
        //Border
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 6.0
 
        self.addTarget(self, action: #selector(LoginTextField.textFieldDidChange(_:)),
                            for: UIControlEvents.editingChanged)
        
        //Keyboard traits
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.spellCheckingType = .no
        self.clearButtonMode = .whileEditing
    }
    
    enum FieldType {
        case email
        case password
        case passwordRetype
        case username
    }
    
    
    
    static func buildLoginTextFieldWith(type : FieldType,
                                        validate : Bool) -> UIView {
        let result = UIView()
        result.translatesAutoresizingMaskIntoConstraints = false
        //We constrain the wrapping UIView's height as well as the actual textField's height (below) to ensure they remain synced
        //There are two height anchors - one for when the errormessage is displayed, and one for when not
        let heightAnchor = result.heightAnchor.constraint(equalTo: result.widthAnchor, multiplier: LoginTextField.textFieldHeightToWidthRatio)
        let heightAnchorError = result.heightAnchor.constraint(equalTo: result.widthAnchor, multiplier: LoginTextField.textFieldAndErrorMessageHeightToWidthRatio)
        heightAnchor.isActive = true
        
        //Based on whether the caller asked for validation, and the button type, determine the errorMessage, validation function, and placeholder
        var errorMessage : String? = nil
        var validation : ((String?) -> Bool)? = nil
        let placeHolder = type == .email ? LoginTextField.emailPlaceholder
            : type == .password ? LoginTextField.passwordPlaceholder
            : type == .passwordRetype ? LoginTextField.passwordRetypePlaceholder
            : LoginTextField.usernamePlaceholder
        if(validate){
            validation = type == .username ? LoginTextField.isValidUsername : type == .email ? LoginTextField.isValidEmail : type == .password ? LoginTextField.isValidPassword  : nil
            errorMessage = type == .username ? LoginTextField.usernameErrorMessage : type == .email ? LoginTextField.emailErrorMessage : type == .password ? LoginTextField.passwordErrorMessage : type == .passwordRetype ? LoginTextField.passwordRetypeErrorMessage : nil
        }
        
        //Now we create the textfield and add it to result
        let textField = LoginTextField(frame:CGRect(x: 0, y: 0, width: 0, height: 0), placeHolder: placeHolder, validation: validation, errorMessage: errorMessage)
        result.addSubview(textField)
        
        //Constrain the size of the textfield and position it relative to the wrapping UIView
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalTo: result.widthAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: result.widthAnchor, multiplier: LoginTextField.textFieldHeightToWidthRatio).isActive = true
        textField.centerXAnchor.constraint(equalTo: result.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: result.topAnchor).isActive = true
        
        
        //IMPORTANT: SAVE THE WRAPPER'S HEIGHTANCHOR IN THE TEXTFIELD TO ALLOW FOR ANIMATION
        textField.wrapperHeightConstraint = heightAnchor
        textField.wrapperWithErrorHeightConstraint = heightAnchorError
        
        //If there's an error message, add it
        if let errorMessage = errorMessage{
            let errorLabel = UILabel()
            errorLabel.attributedText = NSAttributedString(string: errorMessage, attributes: errorMessageAttributes)
            errorLabel.isHidden = true
            
            result.addSubview(errorLabel)
            errorLabel.translatesAutoresizingMaskIntoConstraints = false
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: errorMessageOffset).isActive = true
            errorLabel.centerXAnchor.constraint(equalTo: result.centerXAnchor).isActive = true
        }
        
        //Keyboard traits for specific type of buttons
        if(type == .email){
            textField.keyboardType = .emailAddress
        }
        if(type == .password || type == .passwordRetype){
            textField.keyboardType = .default
            textField.isSecureTextEntry = true;
        }
        
        return result
    }
    
    
    
    //A method that determines whether the current text is valid, and whether it needs to animate in a error message
    //or make the error message disappear
    @objc func textFieldDidChange(_ textField: LoginTextField) throws {
        guard let validation = validation, let wrapper = textField.superview, let text = textField.text else {
            return
        }
        let textValid : Bool
        //If there's no text, we set it to true because we don't want to show an error message if no text available
        if(text.count == 0){
            textValid = true
        }else{
            textValid = validation(text)
        }
        let needsDisplayErrorMessage = !textValid && !textField.wasInErrorState
        let needsHideErrorMessage = textValid && textField.wasInErrorState
        
        //We know the error label is the second view in wrapper
        let errorLabel = wrapper.subviews[1]
        
        
        if(needsDisplayErrorMessage){
            add(errorLabel: errorLabel, toTextField: textField, wrapper: wrapper)
        }else if(needsHideErrorMessage){
            hide(errorLabel: errorLabel, inTextField: textField, wrapper: wrapper)
        }
    }
    
    func hide(errorLabel : UIView, inTextField : LoginTextField, wrapper : UIView){
        inTextField.wasInErrorState = false
        UIView.animate(withDuration: LoginTextField.staticAnimationDuration, animations: {
            errorLabel.alpha = 0.0
        }, completion:{(completed) in
            if(completed){
                inTextField.wrapperWithErrorHeightConstraint.isActive = false
                inTextField.wrapperHeightConstraint.isActive = true
                wrapper.layoutIfNeeded()
                errorLabel.isHidden = true
            }
        })
    }
    
    func add(errorLabel : UIView, toTextField : LoginTextField, wrapper : UIView){
        toTextField.wrapperHeightConstraint.isActive = false
        toTextField.wasInErrorState = true
        //errorLabel.alpha = 0.0
        UIView.animate(withDuration: LoginTextField.staticAnimationDuration, animations:  {
            toTextField.wrapperWithErrorHeightConstraint.isActive = true
            wrapper.layoutIfNeeded()
            errorLabel.isHidden = false
            errorLabel.alpha = 1.0
        })

    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: LoginTextField.textInsetAmount, dy: LoginTextField.textInsetAmount)
    }
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: LoginTextField.textInsetAmount, dy: LoginTextField.textInsetAmount)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func isValidPassword(text: String?) -> Bool{
        if let text = text {
            return text.count >= 7
        }
        else {
            return false
        }
    }
    
    static func isValidEmail(text: String?) -> Bool {
        if let text = text {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: text)
        }else{
            return false
        }
    }
    
    static func isValidUsername(text : String?) -> Bool {
        if let text = text {
            return text.count >= 6  && text.count <= 15
        }
        return false
    }
}
