//
//  PicksMakeEntryView.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/27/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class PicksMakeEntryView : NavViewContainer, UITableViewDataSource {
    override init(navBarDelegate : NavBarDelegate){
        super.init(navBarDelegate : navBarDelegate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
            //contestInfo.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.allowsSelection = false
        let retVal = UITableViewCell()

        return retVal
    }
    
}
