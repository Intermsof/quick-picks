//
//  File.swift
//  quickpicks
//
//  Created by Shreya Jain on 8/30/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import UIKit

class ProfileController : NavbarViewController {
      var viewContainer: ProfileToView!
      var sectionselected : Int!
      var rowselected : Int!
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        let destination = segue.destination as! SettingsController
        print("SELECTION \(sectionselected) and \(rowselected)")
        if sectionselected == 0 && rowselected == 0
        {
            destination.settingPassedIn = .instantReward
        }
        else if sectionselected == 1 && rowselected == 0
        {
           
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
           // destination.settingPassedIn = .logout
            signoutSession()
        }
    }
    
    override func getNavbarTitle() -> String {
        return "PROFILE"
        
    }
    
    
    override func viewDidLoad() {
        viewContainer = ProfileToView(navBarDelegate: self,pcontrol:self)
        viewContainer.addTo(self)
    }
    func seguetoSettings(indexPath:IndexPath){
        print("IN profile Controller You clicked \(indexPath.row) in section \(indexPath.section) ")
        sectionselected=indexPath.section
        rowselected=indexPath.row
        self.performSegue(withIdentifier: SegueConstants.PROFILE_TO_SETTING, sender: indexPath)
    }
    func signoutSession(){
        SettingFirebase.setupSignOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
            self.present(vc, animated: false, completion: nil)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        viewContainer.setupLabelCoin()
    }
}
