//
//  PicksChooseSport.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/20/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class PicksChooseSport : UIViewController {
    var viewContainer : PicksChooseSportView!
    override func viewDidLoad() {
        print("hello world")
        viewContainer = PicksChooseSportView()
        viewContainer.addTo(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear called")
    }
}
