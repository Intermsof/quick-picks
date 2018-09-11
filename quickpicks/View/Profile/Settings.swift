//
//  Settings.swift
//  quickpicks
//
//  Created by Shreya Jain on 7/14/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import UIKit

class Settings:UIViewController,UITableViewDataSource,UITableViewDelegate{

    func leaderboardClicked() {
        print("View Appearing")
    }
    
    enum SettingToDisplay {
        case instantReward
        case orderHistory
        case freeTokens
        case invite
        case share
        case enterCode
        case notiFications
        case help
        case settings
        case logout
    }
    
    var settingPassedIn : SettingToDisplay!
    let help=["FAQ","CONTACT SUPPORT"];
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    // var customNavbar : Navbar!
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        print("Value pressed  \(settingPassedIn.hashValue)")
        
       let textlabel:UILabel = UILabel()
        textlabel.frame = CGRect(x:17 ,y:50,width:self.view.frame.width,height:25)
        //textlabel.frame = CGRect(x:17 ,y:customNavbar.frame.height+20,width:self.view.frame.width,height:25)
        textlabel.font=UIFont(name:"College" , size:17)
        self.view.addSubview(textlabel)
        
   switch settingPassedIn! {
        case .instantReward :
            //textlabel.text="INSTANT REWARD"
            let uiv:UIView = UIView(frame: CGRect(x: 10, y: 45, width: view.frame.width-20, height: 100))
            uiv.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1.0)
            self.view.addSubview(uiv)
            let imagepaypal:UIImage=UIImage(named: "PayPallogo.png")!
            let imageViewP=UIImageView(image: imagepaypal)
            imageViewP.frame = CGRect(x:40,y:60,width:75,height:75)
            self.view.addSubview(imageViewP)
            let text_pay:UILabel = UILabel()
            text_pay.text = "$10 PAYPAL"
            let attributedString1 = NSMutableAttributedString(string: (text_pay.text!))
            attributedString1.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (text_pay.text!.count)))
            text_pay.attributedText = attributedString1
            text_pay.frame = CGRect(x:150 ,y:70,width:200,height:25)
            text_pay.font = UIFont(name : "College" , size:24)
            text_pay.textColor = UIColor.white
            self.view.addSubview(text_pay)
            let text_cost:UILabel = UILabel()
            text_cost.text = "COST:"
            let attributedString2 = NSMutableAttributedString(string: (text_cost.text!))
            attributedString2.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (text_cost.text!.count)))
            text_cost.attributedText = attributedString2
            text_cost.frame = CGRect(x:170 ,y:120,width:50,height:16)
            text_cost.font = UIFont(name : "Oswald" , size:12)
            text_cost.textColor = UIColor.white
            self.view.addSubview(text_cost)
            let uicoin:UIImageView = UIImageView(image: #imageLiteral(resourceName: "Coin"))
            uicoin.frame = CGRect(x:210,y:120,width:15,height:15)
            self.view.addSubview(uicoin)
            let text_no:UILabel = UILabel()
            text_no.text = "100,000"
            let attributedString3 = NSMutableAttributedString(string: (text_no.text!))
            attributedString3.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (text_no.text!.count)))
            text_no.attributedText = attributedString3
            text_no.frame = CGRect(x:240 ,y:117,width:200,height:20)
            text_no.font = UIFont(name : "Oswald" , size:18)
            text_no.textColor = UIColor.white
            self.view.addSubview(text_no)
            let gesture = UITapGestureRecognizer(target: self, action:  #selector (someAction(sender:)))
            uiv.addGestureRecognizer(gesture)
    
    
    
    
        case .orderHistory :
            textlabel.text="ORDER HISTORY"
    
        case .freeTokens:
             textlabel.text="Free Tokens"
    
        case .invite:
             textlabel.text="Invite"
    
        case .share:
             textlabel.text="Share"
    
        case .enterCode:
             textlabel.text="Enter Code"
    
        case .notiFications:
            textlabel.text="Notifications"
    
        case .help:
            textlabel.text="HELP"
            textlabel.textColor = UIColor.lightGray
            let attributedString = NSMutableAttributedString(string: textlabel.text!)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.4, range: NSMakeRange(0, (textlabel.text?.count)!))
            textlabel.attributedText = attributedString
            let tableviewhelp:UITableView = UITableView()
            tableviewhelp.frame=CGRect(x:0,y:Int(textlabel.frame.origin.y+25),width:Int(self.view.frame.width),height:80)
            tableviewhelp.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
            tableviewhelp.dataSource=self
            tableviewhelp.delegate=self
            self.view.addSubview(tableviewhelp)
    
        case .settings:
            textlabel.text="Settings"
    
        case .logout:
            textlabel.text="LOGOUT"
    
        }
 
    }
    
    // TableVIEW FUNCTIONS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if settingPassedIn.hashValue == 7 {
        count = 2
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel?.font=UIFont(name: "Oswald", size:14)
        cell.accessoryType = .disclosureIndicator
        
        if settingPassedIn.hashValue == 7{
            cell.textLabel?.text = help[indexPath.row]
            let attributedString1 = NSMutableAttributedString(string: (cell.textLabel?.text!)!)
            attributedString1.addAttribute(NSAttributedStringKey.kern, value: 1.3, range: NSMakeRange(0, (cell.textLabel?.text!.count)!))
            cell.textLabel?.attributedText=attributedString1
        }
        
        return cell
        
    }
    @objc func someAction(sender:UITapGestureRecognizer){
        // do other task
        let paypal1view :UIView = UIView(frame: CGRect(x: 10, y: 150, width: view.frame.width-20, height: 100))
        paypal1view.backgroundColor = UIColor.white
        self.view.addSubview(paypal1view)
    }

    
    
}
