//
//  SettingsController.swift
//  quickpicks
//
//  Created by Shreya Jain on 9/1/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class SettingsController : NavbarViewController{
      var viewContainer: SettingsToView!
    var sectionselected : Int!
    var rowselected : Int!
    var amount_present = User.shared.coins!
    
    override func getLeftButtonImage() -> UIImage? {
        return #imageLiteral(resourceName: "backbutton")
    }
    
    override func leftButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        let destination = segue.destination as! HelpController
        print("SELECTION \(sectionselected) and \(rowselected)")
        if sectionselected == 0 && rowselected == 0
        {
            destination.helpPassedIn = .faq
        }
        else if sectionselected == 0 && rowselected == 1
        {
            destination.helpPassedIn = .contactsupport
        }
    }
    
    enum SettingToDisplay {
        case instantReward
        case notiFications
        case help
        case settings
        case logout
    }
   var settingPassedIn : SettingToDisplay!
    
    override func viewDidLoad() {
        viewContainer = SettingsToView(navBarDelegate: self,settingPassedInValue:settingPassedIn,settingC:self)
        viewContainer.addTo(self)
    }
    
    func setupAlert(amount:Int){
        if ((amount_present < 10000) && (amount == 1)) || ((amount_present < 50000) && (amount == 5)) {
            let alert_error = UIAlertController(title: "Your current balance is less than 10000", message: "PLAY more games to earn coins...", preferredStyle: .alert)
             alert_error.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert_error, animated: true)
        }
        else {
            
        let alert = UIAlertController(title: "Enter Your Details", message: "Enter Paypal Email & QuickPicks Email", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter your paypal Email here"
        })
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter your quickpicks Email here"
            textField.text = User.shared.email
            textField.isUserInteractionEnabled = false
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let name = alert.textFields?.first?.text {
                print("Your name: \(name)")
            }
            print("Your name: \(alert.textFields![0].text!)")
            SettingFirebase.setupRewards(paypalemail: alert.textFields![0].text!, qpemail: alert.textFields![1].text!, amount: amount)
        }))
        amount_present = amount_present - (amount*10000)
        User.shared.coins = amount_present
        SettingFirebase.updateCoins(amount: amount_present)
        self.present(alert, animated: true)
        }
    }
    
    func seguetoHelp(indexPath:IndexPath){
        print("IN Setting Controller You clicked \(indexPath.row) in section \(indexPath.section) ")
        sectionselected=indexPath.section
        rowselected=indexPath.row
        self.performSegue(withIdentifier: SegueConstants.SETTING_TO_HELP, sender: indexPath)
    }
    
    func clickUpdatePassword(textpassword : UITextField){
        SettingFirebase.updatePassword(password: textpassword.text! )
        print("PASSWORD UPDATED TO \(textpassword.text!)")
    }
}
