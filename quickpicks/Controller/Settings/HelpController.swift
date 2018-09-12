//
//  HelpController.swift
//  quickpicks
//
//  Created by Shreya Jain on 9/3/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class HelpController:NavbarViewController{
     var viewContainer: HelpToView!

    enum HelpToDisplay {
        case faq
        case contactsupport
    }
/*    override func getNavbarTitle() -> String {
        
        switch helpPassedIn {
        case .faq:
            return "FAQ"
        case .contactsupport:
            return "CONTACT SUPPORT"
        case .none:
            return "NONE"
        case .some(_):
            return "SOME"
        }
    }
 */
    
    override func getLeftButtonImage() -> UIImage? {
        return #imageLiteral(resourceName: "backbutton")
    }
    
    override func leftButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    var helpPassedIn : HelpToDisplay!

    override func viewDidLoad() {
        viewContainer = HelpToView(navBarDelegate: self,helpPassedInValue:helpPassedIn,helpC:self)
        viewContainer.addTo(self)
    }
}
