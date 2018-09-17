//
//  PicksMakeEntry.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/24/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class PicksMakeEntry : UIViewController, NavBarDelegate, PicksMakeEntryViewDelegate {
    func infoButtonClicked() {
        print("info clicked")
    }
    
    func submitResults(contestEntry: ContestEntry) {
        let data = contestEntry.toFirebaseModel()
        
        
        if(Sport.selectedSport!.id == "NFL"){
            if let contest = User.shared.NFLcontestEntry{
                let _ = SportFirebase.submitSportEntry(sport: Sport.selectedSport!, user: User.shared, data: data, id: contest.id)
            }
            else{
                contestEntry.id = SportFirebase.submitSportEntry(sport: Sport.selectedSport!, user: User.shared, data: data, id: nil)
            }
            User.shared.NFLcontestEntry = contestEntry
            
        }
        else if(Sport.selectedSport!.id == "NBA"){
            if let contest = User.shared.NBAcontestEntry{
                let _ = SportFirebase.submitSportEntry(sport: Sport.selectedSport!, user: User.shared, data: data, id: contest.id)
            }
            else{
                contestEntry.id = SportFirebase.submitSportEntry(sport: Sport.selectedSport!, user: User.shared, data: data, id: nil)
            }
            User.shared.NBAcontestEntry = contestEntry
        }
        else {
            if let contest = User.shared.MLBcontestEntry{
                let _ = SportFirebase.submitSportEntry(sport: Sport.selectedSport!, user: User.shared, data: data, id: contest.id)
            }
            else{
                contestEntry.id = SportFirebase.submitSportEntry(sport: Sport.selectedSport!, user: User.shared, data: data, id: nil)
            }
            User.shared.MLBcontestEntry = contestEntry
        }
        
        self.navigationController!.popViewController(animated: true)
    }
    
    func getLeftButtonImage() -> UIImage? {
        return #imageLiteral(resourceName: "back")
    }
    
    func leftButtonTapped() {
        print("called")
        //self.dismiss(animated: false, completion: nil)
        self.navigationController!.popViewController(animated: true)
    }
    
    func getNavbarTitle() -> String {
        return Sport.selectedSport!.id
    }
    
    var viewContainer : PicksMakeEntryView!
    override func viewDidLoad() {
        viewContainer = PicksMakeEntryView(navBarDelegate: self, picksMakeEntryViewDelegate: self)
        viewContainer.addTo(self)
    }
    
}
