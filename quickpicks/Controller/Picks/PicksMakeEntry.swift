//
//  PicksMakeEntry.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/24/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class PicksMakeEntry : UIViewController, NavBarDelegate {
    func getLeftButtonImage() -> UIImage? {
        return #imageLiteral(resourceName: "Close")
    }
    
    func leftButtonTapped() {
        print("left button clicked")
    }
    
    func getNavbarTitle() -> String {
        return NavbarTitleConstants.PICKS_MAKE_ENTRY
    }
    
    var viewContainer : PicksMakeEntryView!
    override func viewDidLoad() {
        viewContainer = PicksMakeEntryView(navBarDelegate: self)
        viewContainer.addTo(self)
    }
    
}
