//
//  SettingsToView.swift
//  quickpicks
//
//  Created by Shreya Jain on 9/1/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class SettingsToView : NavViewContainer,UITableViewDataSource,UITableViewDelegate {
    let change_password = UIButton()
    var settingController:SettingsController
    let help=["FAQ","CONTACT SUPPORT"];
    var settingPassedIn : SettingsController.SettingToDisplay
    var selected:Bool = false
    let uiview_password = UITextField()
    let uiview_retypepassword = UITextField()
    let updatepassword = UIButton()
    let terms_conditions = UIButton()
    let privacy_policy = UIButton()
    
    init(navBarDelegate : NavBarDelegate,settingPassedInValue:SettingsController.SettingToDisplay,settingC:SettingsController) {
        settingController = settingC
        settingPassedIn = settingPassedInValue
        super.init(navBarDelegate : navBarDelegate)
        print("Value pressed  \(settingPassedIn.hashValue)")
        setupSettingsChoice()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func fiveDollarAction(sender:UITapGestureRecognizer){
        // do other task
        print("You Tapped 5 Dollar")
        settingController.setupAlert(amount:5)
    }
    @objc func oneDollarAction(sender:UITapGestureRecognizer){
        // do other task
        print("You Tapped 1 Dollar")
        settingController.setupAlert(amount:1)
    }
    
    @objc func clickUpdateAction(sender:UITapGestureRecognizer){
        uiview_password.isUserInteractionEnabled = false
        settingController.clickUpdatePassword(textpassword : uiview_password)
    }
    
    @objc func changingPassword(sender:UITapGestureRecognizer){
        print("IN CHANGE PASSWORD")
        selected = !selected

        if selected {
            
         //Enter Password
        include(uiview_password)
        bindWidth(uiview_password, target: self, 0.65)
        uiview_password.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        centerHorizontally(uiview_password)
        placeBelow(source: uiview_password, target: change_password, padding: 10.0)
        uiview_password.placeholder = "Enter Password Here"
        uiview_password.layer.borderWidth = 0.8
        uiview_password.layer.borderColor = UIColor.gray.cgColor
      
            /*
        //Re-Enter Password
            include(uiview_retypepassword)
            bindWidth(uiview_retypepassword, target: self, 0.65)
            uiview_retypepassword.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
            centerHorizontally(uiview_retypepassword)
            placeBelow(source:uiview_retypepassword, target: uiview_password, padding: 10.0)
            uiview_retypepassword.placeholder = "Re-Enter Password Here"
            uiview_retypepassword.layer.borderWidth = 0.8
            uiview_retypepassword.layer.borderColor = UIColor.gray.cgColor
          */
            
        // Button to Update
            include(updatepassword)
            updatepassword.setTitle("Update Confirm", for: .normal)
            updatepassword.setTitleColor(UIColor.red, for: .normal)
            updatepassword.titleLabel!.font = Fonts.CollegeBoyWithSize(size: 22)
            bindWidth(updatepassword, target: self, 0.667)
            placeBelow(source: updatepassword, target: uiview_password, padding: 20.0)
            centerHorizontally(updatepassword)
            updatepassword.layer.borderWidth = 2.0
            updatepassword.layer.borderColor = UIColor.black.cgColor
            let gestureUpdatePassword = UITapGestureRecognizer(target: self, action:  #selector (clickUpdateAction(sender:)))
            gestureUpdatePassword.numberOfTapsRequired = 1
            updatepassword.addGestureRecognizer(gestureUpdatePassword)
            
        }
        else{
            self.uiview_password.removeFromSuperview()
            //self.uiview_retypepassword.removeFromSuperview()
            self.updatepassword.removeFromSuperview()
        }
        print("VALUE SELECTED\(selected)")
    }
 
    
    func setupSettingsChoice(){
        let textlabel:UILabel = UILabel()
        include(textlabel)
        placeBelow(source: textlabel, target: navbar, padding: 20.0)
        bindLeft(textlabel, target: self, 12.0)
        textlabel.font=UIFont(name:"College" , size:17)
        textlabel.textColor = UIColor.lightGray
        
        switch settingPassedIn {
        case .instantReward :
            textlabel.text="REWARDS :"

            
            //5 Dollar
            let uiv = UIView()
            include(uiv)
            centerHorizontally(uiv)
            bindWidth(uiv, target: self, 0.9)
            bindHeight(uiv, target: self, 0.2)
            placeBelow(source: uiv, target: navbar, padding: 80.0)
            uiv.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1.0)
            let imageViewP=UIImageView(image: #imageLiteral(resourceName: "PayPallogo"))
            uiv.addSubview(imageViewP)
            imageViewP.translatesAutoresizingMaskIntoConstraints = false
            imageViewP.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
            imageViewP.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
            bindLeft(imageViewP, target: uiv, 40.0)
            bindTop(imageViewP, target: uiv, 35.0)
            let text_pay:UILabel = UILabel()
            uiv.addSubview(text_pay)
            text_pay.text = "$5 PAYPAL"
            let attributedString_five1 = NSMutableAttributedString(string: (text_pay.text!))
            attributedString_five1.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (text_pay.text!.count)))
            text_pay.attributedText = attributedString_five1
            text_pay.translatesAutoresizingMaskIntoConstraints = false
            bindLeft(text_pay, target: uiv, 160.0)
            bindTop(text_pay, target: uiv, 40.0)
           // text_pay.frame = CGRect(x:150 ,y:40,width:200,height:25)
            text_pay.font = UIFont(name : "College" , size:24)
            text_pay.textColor = UIColor.white
            let text_cost:UILabel = UILabel()
            uiv.addSubview(text_cost)
            text_cost.text = "COST:"
            let attributedString_five2 = NSMutableAttributedString(string: (text_cost.text!))
            attributedString_five2.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (text_cost.text!.count)))
            text_cost.attributedText = attributedString_five2
            text_cost.frame = CGRect(x:170 ,y:110,width:50,height:16)
            text_cost.font = UIFont(name : "Oswald" , size:12)
            text_cost.textColor = UIColor.white
            let uicoin:UIImageView = UIImageView(image: #imageLiteral(resourceName: "Coin"))
            uiv.addSubview(uicoin)
            uicoin.frame = CGRect(x:210,y:110,width:15,height:15)
            let text_no:UILabel = UILabel()
            uiv.addSubview(text_no)
            text_no.text = "50,000"
            let attributedString_five3 = NSMutableAttributedString(string: (text_no.text!))
            attributedString_five3.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (text_no.text!.count)))
            text_no.attributedText = attributedString_five3
            text_no.frame = CGRect(x:240 ,y:107,width:200,height:20)
            text_no.font = UIFont(name : "Oswald" , size:18)
            text_no.textColor = UIColor.white
            let gesture = UITapGestureRecognizer(target: self, action:  #selector (fiveDollarAction(sender:)))
            gesture.numberOfTapsRequired = 1
            uiv.addGestureRecognizer(gesture)
            
            //1 Dollar
            let uiv_one = UIView()
            include(uiv_one)
            centerHorizontally(uiv_one)
            bindWidth(uiv_one, target: self, 0.9)
            bindHeight(uiv_one, target: self, 0.2)
            placeBelow(source: uiv_one, target: uiv, padding: 30.0)
            uiv_one.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1.0)
            let imageViewP_one=UIImageView(image: #imageLiteral(resourceName: "PayPallogo"))
            uiv_one.addSubview(imageViewP_one)
            imageViewP_one.translatesAutoresizingMaskIntoConstraints = false
            imageViewP_one.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
            imageViewP_one.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
            bindLeft(imageViewP_one, target: uiv_one, 40.0)
            bindTop(imageViewP_one, target: uiv_one, 35.0)
            let text_pay_one:UILabel = UILabel()
            uiv_one.addSubview(text_pay_one)
            text_pay_one.text = "$1 PAYPAL"
            let attributedString_one1 = NSMutableAttributedString(string: (text_pay_one.text!))
            attributedString_one1.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (text_pay_one.text!.count)))
            text_pay_one.attributedText = attributedString_one1
            text_pay_one.translatesAutoresizingMaskIntoConstraints = false
            bindLeft(text_pay_one, target: uiv_one, 160.0)
            bindTop(text_pay_one, target: uiv_one, 40.0)
            text_pay_one.font = UIFont(name : "College" , size:24)
            text_pay_one.textColor = UIColor.white
            let text_cost_one:UILabel = UILabel()
            uiv_one.addSubview(text_cost_one)
            text_cost_one.text = "COST:"
            let attributedString_one2 = NSMutableAttributedString(string: (text_cost_one.text!))
            attributedString_one2.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (text_cost_one.text!.count)))
            text_cost_one.attributedText = attributedString_one2
            text_cost_one.frame = CGRect(x:170 ,y:110,width:50,height:16)
            text_cost_one.font = UIFont(name : "Oswald" , size:12)
            text_cost_one.textColor = UIColor.white
            let uicoin_one:UIImageView = UIImageView(image: #imageLiteral(resourceName: "Coin"))
            uiv_one.addSubview(uicoin_one)
            uicoin_one.frame = CGRect(x:210,y:110,width:15,height:15)
            let text_no_one:UILabel = UILabel()
            uiv_one.addSubview(text_no_one)
            text_no_one.text = "10,000"
            let attributedString_one3 = NSMutableAttributedString(string: (text_no_one.text!))
            attributedString_one3.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (text_no_one.text!.count)))
            text_no_one.attributedText = attributedString_one3
            text_no_one.frame = CGRect(x:240 ,y:107,width:200,height:20)
            text_no_one.font = UIFont(name : "Oswald" , size:18)
            text_no_one.textColor = UIColor.white
            let gesture_one = UITapGestureRecognizer(target: self, action:  #selector (oneDollarAction(sender:)))
            gesture_one.numberOfTapsRequired = 1
            uiv_one.addGestureRecognizer(gesture_one)
            
            
            
        case .notiFications:
            textlabel.text="Notifications"
            
            
        case .help:
            textlabel.text="HELP"
            let tableviewhelp:UITableView = UITableView()
            include(tableviewhelp)
            placeBelow(source: tableviewhelp, target: textlabel, padding: 10.0)
            bindWidth(tableviewhelp, target: self, 1.0)
            //bindHeight(tableviewhelp, target: self, 0.15)
            bindTop(tableviewhelp, target: textlabel, 30.0)
            bindBottom(tableviewhelp, target: self, 30.0)
            tableviewhelp.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell_help")
            tableviewhelp.dataSource=self
            tableviewhelp.delegate=self
            tableviewhelp.tableFooterView = UIView()
            
            
        case .settings:
            textlabel.text="Settings"
            //Change Password button
            include(change_password)
            change_password.setTitle("Change Password", for: .normal)
            change_password.setTitleColor(UIColor.black, for: .normal)
            change_password.titleLabel!.font = Fonts.CollegeBoyWithSize(size: 22)
            bindWidth(change_password, target: self, 0.715)
            placeBelow(source: change_password, target: textlabel, padding: 20.0)
            centerHorizontally(change_password)
            change_password.layer.borderWidth = 2.0
            change_password.layer.borderColor = UIColor.black.cgColor
            let gesture_password = UITapGestureRecognizer(target: self, action:  #selector (changingPassword(sender:)))
            gesture_password.numberOfTapsRequired = 1
            change_password.addGestureRecognizer(gesture_password)
            
            //Terms & Conditions
            include(terms_conditions)
            terms_conditions.setTitle("Terms & Conditions", for: .normal)
            terms_conditions.setTitleColor(UIColor.black, for: .normal)
            terms_conditions.titleLabel!.font = Fonts.CollegeBoyWithSize(size: 22)
            bindWidth(terms_conditions, target: self, 0.715)
            placeBelow(source: terms_conditions, target: change_password, padding: 100.0)
            centerHorizontally(terms_conditions)
            terms_conditions.layer.borderWidth = 2.0
            terms_conditions.layer.borderColor = UIColor.black.cgColor
 
            //Privacy Policy
            
            include(privacy_policy)
            privacy_policy.setTitle("Privacy Policy", for: .normal)
            privacy_policy.setTitleColor(UIColor.black, for: .normal)
            privacy_policy.titleLabel!.font = Fonts.CollegeBoyWithSize(size: 22)
            bindWidth(privacy_policy, target: self, 0.715)
            placeBelow(source: privacy_policy, target: terms_conditions, padding: 100.0)
            centerHorizontally(privacy_policy)
            privacy_policy.layer.borderWidth = 2.0
            privacy_policy.layer.borderColor = UIColor.black.cgColor
            
            
        case .logout:
            textlabel.text="LOGOUT"
            
        }
        
        let attributedString = NSMutableAttributedString(string: textlabel.text!)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.4, range: NSMakeRange(0, (textlabel.text?.count)!))
        textlabel.attributedText = attributedString
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("You clicked \(indexPath.row) in section \(indexPath.section) ")
        if settingPassedIn.hashValue == 2 {
         settingController.seguetoHelp(indexPath:indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if settingPassedIn.hashValue == 2 {
            count = 2
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "MyCell_help", for: indexPath as IndexPath)
        cell.textLabel?.font=UIFont(name: "Oswald", size:14)
        cell.accessoryType = .disclosureIndicator
        
        if settingPassedIn.hashValue == 2{
            cell.textLabel?.text = help[indexPath.row]
            let attributedString1 = NSMutableAttributedString(string: (cell.textLabel?.text!)!)
            attributedString1.addAttribute(NSAttributedStringKey.kern, value: 1.3, range: NSMakeRange(0, (cell.textLabel?.text!.count)!))
            cell.textLabel?.attributedText=attributedString1
        }
        return cell
    }
    
}
