//
//  LiveGamesTable.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 9/5/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class LiveGamesTable : UITableView, UITableViewDataSource, UITableViewDelegate {
    var sport : Sport
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sport.currentContest.gameIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameID = sport.currentContest.gameIDs[indexPath.row]
        let game = sport.currentContest.games[gameID]!
        return makeCell(game: game)
    }
    
    init(sport : Sport){
        self.sport = sport
        super.init(frame : CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
    }
    
    func setSport(sport: Sport){
        self.sport = sport
        self.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCell(game : Game) -> UITableViewCell{
        let cell = UITableViewCell()
        
        let homeTeamName = UILabel()
        let homeTeamScore = UILabel()
        let awayTeamName = UILabel()
        let awayTeamScore = UILabel()
        let completeIndicator = UIView()
        let incompleteIndicator = UIView()
        
        cell.addSubview(homeTeamName)
        cell.addSubview(homeTeamScore)
        cell.addSubview(awayTeamName)
        cell.addSubview(awayTeamScore)
        cell.addSubview(completeIndicator)
        cell.addSubview(incompleteIndicator)
        
        let font = Fonts.OswaldWithSize(size: 20)
        let fontLarge = Fonts.OswaldWithSize(size: 25)
        
        homeTeamName.text = game.homeTeamName
        homeTeamScore.text = String(game.homeTeamScore)
        awayTeamName.text = game.awayTeamName
        awayTeamScore.text = String(game.awayTeamScore)
        
        homeTeamName.font = fontLarge
        homeTeamScore.font = font
        awayTeamName.font = fontLarge
        awayTeamScore.font = font
        
        homeTeamName.translatesAutoresizingMaskIntoConstraints = false
        homeTeamScore.translatesAutoresizingMaskIntoConstraints = false
        awayTeamName.translatesAutoresizingMaskIntoConstraints = false
        awayTeamScore.translatesAutoresizingMaskIntoConstraints = false
        completeIndicator.translatesAutoresizingMaskIntoConstraints = false
        incompleteIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        homeTeamName.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        homeTeamScore.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        awayTeamName.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        awayTeamScore.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        
        let quarter = 0.25 * self.frame.width
        let centerOfQuarter = 0.5 * quarter
        homeTeamName.centerXAnchor.constraint(equalTo: cell.leftAnchor, constant: centerOfQuarter).isActive = true
        homeTeamScore.centerXAnchor.constraint(equalTo: cell.leftAnchor, constant: quarter + centerOfQuarter).isActive = true
        awayTeamName.centerXAnchor.constraint(equalTo: cell.centerXAnchor, constant: centerOfQuarter).isActive = true
        awayTeamScore.centerXAnchor.constraint(equalTo: cell.centerXAnchor, constant: quarter + centerOfQuarter).isActive = true
        
        completeIndicator.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        incompleteIndicator.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        completeIndicator.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        incompleteIndicator.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        
        completeIndicator.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        let completeIndicatorRightConstraint = completeIndicator.rightAnchor.constraint(equalTo: cell.leftAnchor)

        switch game.gameState {
        case 1:
            completeIndicatorRightConstraint.constant = quarter
        case 2:
            completeIndicatorRightConstraint.constant = 2 * quarter
        case 3:
            completeIndicatorRightConstraint.constant = 3 * quarter
        default:
            completeIndicatorRightConstraint.constant = 0
        }
        
        let finishedConstraint = completeIndicator.rightAnchor.constraint(equalTo: cell.rightAnchor)
        if(game.gameState == 5){
            finishedConstraint.isActive = true
        }
        else{
            completeIndicatorRightConstraint.isActive = true
        }
        
        incompleteIndicator.leftAnchor.constraint(equalTo: completeIndicator.rightAnchor).isActive = true
        incompleteIndicator.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        
        completeIndicator.backgroundColor = Colors.QPGreenLight
        incompleteIndicator.backgroundColor = Colors.QPRed
        
        cell.selectionStyle = .none
        return cell
    }
}
