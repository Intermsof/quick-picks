//
//  NavbarViewController.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/27/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class NavbarViewController : UIViewController, NavBarDelegate {
    func getLeftButtonImage() -> UIImage? {
        return #imageLiteral(resourceName: "Ladder")
    }
    
    func leftButtonTapped() {
        print("to leaderboard later")
    }
    
    func getNavbarTitle() -> String {
        return NavbarTitleConstants.DEFAULT
    }
    
}
