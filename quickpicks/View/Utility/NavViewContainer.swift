//
//  NavEnabledViewContainer.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/20/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

class NavViewContainer : ViewContainer {
    
    //Assumes that the controller always has a navigationController
    override func addTo(_ controller: UIViewController) {
        let navBar = NavBar(frame: controller.navigationController?.frame, string: "some string", option: .displayCoins)
    }
}
