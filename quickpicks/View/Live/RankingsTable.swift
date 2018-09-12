//
//  RankingsTable.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 9/5/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class RankingsTable : UITableView, UITableViewDataSource, UITableViewDelegate {
    var sport : Sport
    init(sport : Sport){
        self.sport = sport
        super.init(frame : CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sport.dailyLB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ranking = sport.dailyLB[indexPath.row]
        return makeCell(ranking: ranking)
    }
    
    func makeCell(ranking: Ranking) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let position = UILabel()
        let username = UILabel()
        let score = UILabel()
        
        let font = Fonts.OswaldWithSize(size: 20)
        
        position.font = font
        username.font = font
        score.font = font

        position.text = "\(ranking.position)."
        username.text = String(ranking.username)
        score.text = String(ranking.score)
        
        position.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        score.translatesAutoresizingMaskIntoConstraints = false
        
        cell.addSubview(position)
        cell.addSubview(username)
        cell.addSubview(score)
        
        let positionStart = 0.05 * self.frame.width
        let usernameStart = 0.20 * self.frame.width
        let scoreStart = 0.75 * self.frame.width
        
        position.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: positionStart).isActive = true
        username.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: usernameStart).isActive = true
        score.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: scoreStart).isActive = true
        
        position.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        username.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        score.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        
        let bottomLine = UIView()
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(bottomLine)
        bottomLine.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        bottomLine.backgroundColor = Colors.QPGrey
        
        cell.selectionStyle = .none
        return cell
    }
}
