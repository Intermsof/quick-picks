//
//  MakeEntryTable.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 9/12/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class MakeEntryTable : UITableView, UITableViewDelegate, UITableViewDataSource{
    var pickable = true
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sport.currentContest.gameIDs.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.allowsSelection = false
        let gameID = self.sport.currentContest.gameIDs[indexPath.row]
        let game = self.sport.currentContest.games[gameID]
        let retVal = MakeEntryTableviewCell(game: game!)
        retVal.awayTeamTapReceiver.setBackgroundColor(state: .off)
        retVal.homeTeamTapReceiver.setBackgroundColor(state: .off)
        
        if let entry = existingContestEntry {
            let pick = entry.picks[indexPath.row]
            if(pick == 0){
                retVal.updateSelection(team: .home)
            }
            else{
                retVal.updateSelection(team: .away)
            }
        }
        
        if(self.pickable){
            retVal.isUserInteractionEnabled = true
        }
        else{
            retVal.isUserInteractionEnabled = false
        }
        return retVal
    }
    
    func setPickable(_ value : Bool){
        self.pickable = value
        self.reloadData()
    }
    
    var existingContestEntry : ContestEntry?
    var sport : Sport
    init(sport: Sport, existingContestEntry : ContestEntry?){
        self.sport = sport
        self.existingContestEntry = existingContestEntry
        super.init(frame : CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        self.dataSource = self
        self.delegate = self
    }
    
    func setSport(sport: Sport){
        self.sport = sport
        self.reloadData()
    }
    
    func setContestEntry(contestEntry: ContestEntry?){
        if let contestEntry = contestEntry {
            self.existingContestEntry = contestEntry
            self.reloadData()
        }
    }
    
    func getPicks() -> [Int]{
        let rows = self.numberOfRows(inSection: 0)
        var picks = [Int]()
        for index in 0..<rows{
            let cell = self.cellForRow(at: IndexPath(row: index, section: 0)) as! MakeEntryTableviewCell
            if(cell.teamPicked == .home){
                picks.append(0)
            }
            else{
                picks.append(1)
            }
        }
        return picks
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
