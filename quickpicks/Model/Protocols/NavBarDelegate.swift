//
//  NavbarDelegate.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/23/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

protocol NavBarDelegate {
    func getLeftButtonImage() -> UIImage?
    func leftButtonTapped ()
    func getNavbarTitle () -> String
}
