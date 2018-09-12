//
//  MyPicksTable.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 9/5/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class MyPicksTable : UITableView, UITableViewDataSource, UITableViewDelegate {
    var contestEntry : ContestEntry?
    var sport : Sport
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let contestEntry = contestEntry {
            return contestEntry.picks.count + 1
        }
        return 0
    }
    
    init(sport: Sport, contestEntry: ContestEntry?){
        self.sport = sport
        self.contestEntry = contestEntry
        super.init(frame : CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            return makeHeader()
        }
        else{
            let index = indexPath.row - 1
            let pick = contestEntry!.picks[index]
            let gameID = sport.currentContest.gameIDs[index]
            let game = sport.currentContest.games[gameID]
            
            var team : String
            if(pick == 0){
                team = game!.homeTeamName
            }
            else{
                team = game!.awayTeamName
            }
            
            if let teams = sport.teams {
                return makeCell(team: teams[team.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)]!)
            }
            else{
                return makeCell(team: team)
            }
        }
    }
    
    func makeHeader() -> UITableViewCell {
        let cell = UITableViewCell()
        
        let label = UILabel()
        label.text = "NFL    \(contestEntry!.date)"
        label.font = Fonts.OswaldWithSize(size: 30)
        
        cell.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        
        return cell
    }
    
    func makeCell(team : String) -> UITableViewCell{
        let cell = UITableViewCell()
        
        let teamName = UILabel()
        teamName.text = team
        teamName.font = Fonts.CollegeBoyWithSize(size: 25)
        
        cell.addSubview(teamName)
        
        teamName.translatesAutoresizingMaskIntoConstraints = false
        teamName.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        teamName.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        
        let bottomLine = UIView()
        cell.addSubview(bottomLine)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        bottomLine.backgroundColor = Colors.QPGrey
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
