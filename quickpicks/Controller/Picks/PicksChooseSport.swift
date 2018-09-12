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
        self.performSegue(withIdentifier: SegueConstants.PICKSCHOOSESPORT_PICKSMAKEENTRY, sender: self)
        Sport.selectedSport = sport
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
            if let sports = sports{
                self.sports = sports
                self.viewContainer.layoutIfNeeded()
                self.viewContainer.drawSports(sports)
                Sport.sports = sports
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let sports = sports{
            self.viewContainer.drawSports(sports)
        }
    }

}
