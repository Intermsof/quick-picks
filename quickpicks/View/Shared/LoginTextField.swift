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
    let textField = InsetTextfield()
    
    static let errorMessageAttributes : [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 14),
                                                                         NSAttributedStringKey.kern : 1.5,
                                                                         NSAttributedStringKey.foregroundColor : Colors.QPRed]

    //Variables for setting up placeholder and user typed text
    let textFont : UIFont
    let textColor : UIColor
    let textKerning : NSNumber
    let validator : ((String) -> Bool)?
    let height : CGFloat?
    let errorMessage : String?
    let errorLabel = UILabel()
    var textFieldHeightConstraint : NSLayoutConstraint!
    var selfHeightConstraint : NSLayoutConstraint!
    var errorBottomConstraint : NSLayoutConstraint!
    
    func setupTextfield(){
        textField.delegate = self
        textField.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        textField.textColor = UIColor.white
        
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
        textFieldHeightConstraint = textField.heightAnchor.constraint(equalTo: self.heightAnchor)
        textFieldHeightConstraint.isActive = true
        textField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        textField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    init(placeHolder: String, validator: ((String) -> Bool)? = nil, errorMessage: String? = nil, height: CGFloat? = nil){
        if(validator != nil && height == nil){
            print("if validator is not nil, height cannot be nil. This WILL crash!")
        }
        self.validator = validator
        self.height = height
        self.errorMessage = errorMessage
        //Variables for setting up placeholder and user typed text
        textFont = Fonts.CollegeBoyWithSize(size: 18)
        textColor = UIColor.white
        textKerning = NSNumber(value: 1.0)
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupTextfield()
        setPlaceholder(placeHolder)
    
        if (errorMessage != nil){
            setupErrorLabel()
        }
        
        if let height = height {
            selfHeightConstraint = self.heightAnchor.constraint(equalToConstant: height)
            selfHeightConstraint?.isActive = true
        }
    }
    
    func setupErrorLabel(){
        self.addSubview(errorLabel)
        errorLabel.attributedText = NSAttributedString(string: errorMessage!, attributes: LoginTextField.errorMessageAttributes)
        errorLabel.isHidden = true
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        errorBottomConstraint = errorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        errorBottomConstraint.isActive = true
        errorBottomConstraint.constant = 5
    }
    
    func setPlaceholder(_ placeholder : String){
        //Styling for placeholder text
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedStringKey.font : textFont,
            NSAttributedStringKey.foregroundColor : textColor,
            NSAttributedStringKey.kern : textKerning])
    }
    
    @objc func textFieldDidChange() {
        guard let text = textField.text else {
            return
        }
        if (text.isEmpty) {
            hideErrorMessage()
            return
        }
        
        if let validator = validator {
            let valid = validator(text)
            if(!valid){
                displayErrorMessage()
            }
            else{
                hideErrorMessage()
            }
        }
        print(text)
    }
    
    func hideErrorMessage(){
        if(isErrorMessageVisible){
            isErrorMessageVisible = false
            UIView.animate(withDuration: 0.1) {
                self.selfHeightConstraint.constant -= 40
                self.textFieldHeightConstraint.constant += 40
                
                self.errorLabel.isHidden = true
                self.superview!.layoutIfNeeded()
            }
        }
    }
    var isErrorMessageVisible = false
    func displayErrorMessage(){
        if(!isErrorMessageVisible){
            isErrorMessageVisible = true
            UIView.animate(withDuration: 0.1) {
                self.selfHeightConstraint.constant += 40
                self.textFieldHeightConstraint.constant -= 40
                self.errorLabel.isHidden = false
                self.superview!.layoutIfNeeded()
            }
        }
        
        print("has error")
        
    }
    

    /*
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

}
