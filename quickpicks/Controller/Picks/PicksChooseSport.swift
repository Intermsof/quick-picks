//
//  PicksChooseSport.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/20/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class PicksChooseSport : NavbarViewController, PicksChooseSportViewDelegate {
    var sports : [Sport]?
    
    func sportButtonTapped(sport: Sport) {
        self.performSegue(withIdentifier: SegueConstants.PICKSCHOOSESPORT_PICKSMAKEENTRY, sender: sport)
    }
    
    override func getNavbarTitle() -> String {
        return NavbarTitleConstants.PICKS_CHOOSE_SPORTS
    }
    
    var viewContainer : PicksChooseSportView!
    
    override func viewDidLoad() {
        print("hello world")
        viewContainer = PicksChooseSportView(navBarDelegate: self, picksChooseSportViewDelegate : self)
        viewContainer.addTo(self)
        
        SportFirebase.getActiveSports { (sports) in
            print(sports)
            if let sports = sports{
                self.sports = sports
                self.viewContainer.drawSports(sports)
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        if let sports = self.sports{
            self.viewContainer.drawSports(sports)
        }
        
    }

}
