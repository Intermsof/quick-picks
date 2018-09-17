//
//  File.swift
//  quickpicks
//
//  Created by Shreya Jain on 8/30/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//
import Foundation
import UIKit

class ProfileToView : NavViewContainer,UITableViewDelegate,UITableViewDataSource{
    
    let winnings=["INSTANT REWARDS"]
    let account=["NOTIFICATIONS","HELP","SETTINGS","LOGOUT"]
    var mySwitch = UISwitch()
    
    let label_name = UILabel()
    let linehorizontal = UIView()
    let label_coins = UILabel()
    let tableView1 = UITableView()
    let pController:ProfileController
    
    init(navBarDelegate : NavBarDelegate,pcontrol:ProfileController) {
        pController = pcontrol
        super.init(navBarDelegate : navBarDelegate)
        include(label_name)
        include(linehorizontal)
        include(label_coins)
        include(tableView1)
        setupLabelName()
        setupLine()
        setupLabelCoin()
        setupTableView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLabelName(){
        //Label for Name
        centerHorizontally(label_name)
        label_name.font = UIFont(name:"Oswald", size: 22)
        label_name.text=User.shared.username
        let attributedString = NSMutableAttributedString(string: label_name.text!)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.0, range: NSMakeRange(0, (label_name.text?.count)!))
        label_name.attributedText = attributedString
        //let image = UIImage(imageLiteralResourceName: "Ladder")
        //let image = UIImageView(image: #imageLiteral(resourceName: "Ladder"))
        placeBelow(source: label_name, target: navbar, padding: 10)
        
    }
    
    func setupLine(){
        linehorizontal.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bindWidth(linehorizontal, target: self, 0.7)
        linehorizontal.backgroundColor=UIColor.black
        centerHorizontally(linehorizontal)
        placeBelow(source: linehorizontal, target: label_name, padding: 20)
    }
    func setupLabelCoin(){
        centerHorizontally(label_coins)
        label_coins.text  = String(User.shared.coins)
        label_coins.textColor = UIColor(red: 154/255, green: 205/255, blue: 50/255, alpha: 1.0)
        label_coins.font = UIFont(name:"Oswald-Bold", size: 18.0)
        placeBelow(source: label_coins, target: linehorizontal, padding: 30)
    }
    
    func setupTableView(){
        bindWidth(tableView1, target: self, 1.0)
        bindHeight(tableView1, target: self, 0.42)
        placeBelow(source: tableView1, target: label_coins, padding: 20)
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell1")
        tableView1.dataSource=self
        tableView1.delegate=self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You clicked \(indexPath.row) in section \(indexPath.section) ")
        //pController = ProfileController()
        pController.seguetoSettings(indexPath:indexPath)
        tableView1.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return winnings.count
        case 1:
            return account.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerview = UIView()
        let linehorizontal1 = UIView()
        
        //let headerview = tableView.dequeueReusableCell(withIdentifier: "MyCell1")! as! UITableViewCell
        
        //black line
        //bindHeight(linehorizontal1, target: tableView1, 0.006)
        //bindWidth(linehorizontal1, target: tableView1, 1.0)
        linehorizontal1.translatesAutoresizingMaskIntoConstraints = false
        headerview.addSubview(linehorizontal1)
        linehorizontal1.widthAnchor.constraint(equalTo: headerview.widthAnchor).isActive = true
        linehorizontal1.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
        linehorizontal1.backgroundColor=UIColor.gray
        
        
      // header text
        headerview.backgroundColor = UIColor.white
        let headerLabel = UILabel()
        headerview.addSubview(headerLabel)
        headerLabel.frame = CGRect(x: 17.0, y: 8, width:tableView.frame.size.width, height: tableView.frame.size.height)
        headerLabel.font = UIFont(name: "Oswald", size: 14)
        headerLabel.textColor = UIColor.gray
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.textAlignment = .left
        
        //Spacing between text in headerlabel
        let attributedString = NSMutableAttributedString(string: headerLabel.text!)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (headerLabel.text?.count)!))
        headerLabel.attributedText = attributedString
        headerLabel.sizeToFit()
        return headerview
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "WINNINGS"
        case 1:
            return "GENERAL"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "MyCell1", for: indexPath as IndexPath)
        cell.selectionStyle = .none
        cell.textLabel?.font=UIFont(name: "Oswald", size:13)
        
        cell.accessoryType = .disclosureIndicator;
        
        // Switch
        if indexPath.section==1 && indexPath.row==0{
            var checkNotifications = User.shared.notifications!
            mySwitch.setOn(checkNotifications, animated: false)
            cell.accessoryView = mySwitch
            self.addSubview(mySwitch)
            print("VAL AAA \(mySwitch.isOn)")
            mySwitch.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
        }
        
        switch indexPath.section{
        case 0:
            cell.textLabel?.text=winnings[indexPath.row]
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
        SettingFirebase.updateNotifications(nval: val)
    }
    
}
