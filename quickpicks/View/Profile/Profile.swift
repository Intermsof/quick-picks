
//
//  ViewController.swift
//  StaticProfilePage
//
//  Created by Shreya Jain on 6/26/18.
//  Copyright © 2018 example. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


class Profile: UIViewController,UITableViewDelegate,UITableViewDataSource{

    func notifySuccess() {
        print("Update successfull")
    }
    
    func notifyFailure() {
        print("Update Failed")
        
    }
    
    func leaderboardClicked() {
            print("leaderboard clicked")
    }

    
    let winnings=["INSTANT REWARDS"]
    //let invite=["INVITE","SHARE","ENTER CODE"]
    let account=["NOTIFICATIONS","HELP","SETTINGS","LOGOUT"]
    var sectionselected : Int!
    var rowselected : Int!
    var customNavbar : Navbar!
    var mySwitch = UISwitch()
    //Segue for the next view
    
   override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        let destination = segue.destination as! Settings
    print("SELECTION \(sectionselected) and \(rowselected)")
        if sectionselected == 0 && rowselected == 0
        {
        destination.settingPassedIn = .instantReward
        }
    /*else if sectionselected == 0 && rowselected == 1
        {
         destination.settingPassedIn = .orderHistory
        }
    else if sectionselected == 0 && rowselected == 2
        {
            destination.settingPassedIn = .freeTokens
        }
    else if sectionselected == 1 && rowselected == 0
        {
            destination.settingPassedIn = .invite
        }
        else if sectionselected == 1 && rowselected == 1
        {
            destination.settingPassedIn = .share
        }
        else if sectionselected == 1 && rowselected == 2
        {
            destination.settingPassedIn = .enterCode
        }
 */
        else if sectionselected == 1 && rowselected == 0
        {
            destination.settingPassedIn = .notiFications
        }
        else if sectionselected == 1 && rowselected == 1
        {
            destination.settingPassedIn = .help
        }
        else if sectionselected == 1 && rowselected == 2
        {
            destination.settingPassedIn = .settings
        }
        else if sectionselected == 1 && rowselected == 3
        {
            destination.settingPassedIn = .logout
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Nav Bar
     /*   RealtimeModel.shared.printMe()
        self.customNavbar = Navbar(frame: (self.navigationController?.navigationBar.frame)!, string: "Profile", option:.displayCoins, delegate: self)
           print("view appearing")
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
          self.view.addSubview(customNavbar)
        */
        
        //Profile Picture
       /*let image:UIImage=UIImage(named: "pro_pic.png")!
        let imageView=UIImageView(image: image)
        self.view.addSubview(imageView)
        imageView.frame = CGRect(x:0,y:0,width:120,height:150)
        imageView.center.x=self.view.center.x
        //imageView.frame.origin.y=customNavbar.frame.height+20
    */
        
        //Label for Name
        let label_name:UILabel=UILabel(frame: CGRect(x:0,y:0,width:50,height:25))
        label_name.font = UIFont(name:"Oswald", size: 20)
        label_name.text="NAME"
        self.view.addSubview(label_name)
        label_name.center.x=self.view.center.x
         label_name.frame.origin.y=40
        
        //Add space between characters
        let attributedString = NSMutableAttributedString(string: label_name.text!)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.0, range: NSMakeRange(0, (label_name.text?.count)!))
        label_name.attributedText = attributedString
        
        
        //Line between Name & Coins
        let linehorizontal:UIView=UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 1))
        linehorizontal.backgroundColor=UIColor.black
        linehorizontal.center.x=self.view.center.x
        linehorizontal.frame.origin.y=label_name.frame.origin.y+30
        self.view.addSubview(linehorizontal)
        
        
        //Label for Coins
        let label_coins:UILabel=UILabel(frame: CGRect(x:0,y:0,width:70,height:25))
        label_coins.text="438,000"
        label_coins.textColor=UIColor(red: 154/255, green: 205/255, blue: 50/255, alpha: 1.0)
        label_coins.font = UIFont(name:"Oswald-Bold", size: 18.0)
        self.view.addSubview(label_coins)
        label_coins.center.x=self.view.center.x
        label_coins.frame.origin.y=label_name.frame.origin.y+50
        
        //Calculate height
        let h_val=self.view.frame.height
        let hforTableView=h_val-label_coins.frame.origin.y-30
        
        //Table View
        let tableView:UITableView=UITableView()
        tableView.frame=CGRect(x:0,y:Int(label_coins.frame.origin.y+30),width:Int(self.view.frame.width),height:Int(hforTableView))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell1")
        tableView.dataSource=self
        tableView.delegate=self
        tableView.sizeToFit()
        self.view.addSubview(tableView)
        
        //To know all the fonts
        /*   for family: String in UIFont.familyNames
         {
         print("\(family)")
         for names: String in UIFont.fontNames(forFamilyName: family)
         {
         print("== \(names)")
         }
         }
         */
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You clicked \(indexPath.row) in section \(indexPath.section) ")
        sectionselected=indexPath.section
        rowselected=indexPath.row
        self.performSegue(withIdentifier: "mySegueID", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return winnings.count
       /* case 1:
            return invite.count
        */
        case 1:
            return account.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
       let headerview = UIView()
        
        
       //let headerview = tableView.dequeueReusableCell(withIdentifier: "MyCell1")! as! UITableViewCell
        
        //black line
        let linehorizontal:UIView   =   UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 0.6))
        linehorizontal.backgroundColor=UIColor.gray
        headerview.addSubview(linehorizontal)
        
        // header text
        headerview.backgroundColor = UIColor.white
        let headerLabel = UILabel(frame: CGRect(x: 17.0, y: 8, width:tableView.frame.size.width, height: tableView.frame.size.height))
        headerLabel.font = UIFont(name: "Oswald", size: 14)
        headerLabel.textColor = UIColor.gray
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.textAlignment = .left

        //Spacing between text in headerlabel
        let attributedString = NSMutableAttributedString(string: headerLabel.text!)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (headerLabel.text?.count)!))
        headerLabel.attributedText = attributedString
        
        headerLabel.sizeToFit()
        
        headerview.addSubview(headerLabel)
        return headerview
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "WINNINGS"
       /* case 1:
            return "SOCIAL"
        */
        case 1:
            return "GENERAL"
            
        default:
            return nil
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "MyCell1", for: indexPath as IndexPath)
        cell.textLabel?.font=UIFont(name: "Oswald", size:13)
      
        cell.accessoryType = .disclosureIndicator;
        
        // Switch
        if indexPath.section==2 && indexPath.row==0{
           
            mySwitch.setOn(false, animated: false)
          //  FirebaseManager.shared.updateInfo(nval:false , controller: self)
            cell.accessoryView = mySwitch
            self.view.addSubview(mySwitch)
            print("VAL AAA \(mySwitch.isOn)")
            mySwitch.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
        }
        
        switch indexPath.section{
        case 0:
            cell.textLabel?.text=winnings[indexPath.row]
        /*case 1:
            cell.textLabel?.text=invite[indexPath.row]
        */
        case 1:
            cell.textLabel?.text=account[indexPath.row]
        default:
            cell.textLabel?.text="Default"
            
        }
        let attributedString1 = NSMutableAttributedString(string: (cell.textLabel?.text!)!)
        attributedString1.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (cell.textLabel?.text!.count)!))
        cell.textLabel?.attributedText=attributedString1
     //   cell.textLabel?.font = cell.textLabel?.font.withSize(8)
        return cell
    }
    
    // Notification Switch
    @objc func switchChanged(mySwitch: UISwitch) {
        var val=mySwitch.isOn
        print("VAL of switch is \(mySwitch.isOn)")
        //FirebaseManager.shared.updateInfo(nval:val , controller: self)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}

