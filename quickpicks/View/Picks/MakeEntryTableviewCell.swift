//
//  MakeEntryTableviewCell.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/27/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

enum MakeEntryTeam{
    case home
    case away
}

enum Toggleable{
    case on
    case off
}

class MakeEntryTableviewCell : UITableViewCell {
    class TapReceiver : UIView {
        let team : MakeEntryTeam
        let PADDING : CGFloat = 2.5
        let backgroundView = UIView()
        
        init(team: MakeEntryTeam){
            self.team = team
            super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.translatesAutoresizingMaskIntoConstraints = false
            setupBackground()
            //let tapRecognizer = UITapGestureRecognizer
        }
        
        func setupBackground(){
            self.addSubview(backgroundView)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: PADDING).isActive = true
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -PADDING).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: PADDING).isActive = true
            backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -PADDING).isActive = true
        }
        
        func setBackgroundColor(state : Toggleable){
            if(state == .on){
                backgroundView.backgroundColor = Colors.QPGreenLight
            }
            else{
                 backgroundView.backgroundColor = UIColor.white
            }
        }
        
        @objc func tapped(){
            let superView = self.superview as! MakeEntryTableviewCell
            superView.updateSelection(team: self.team)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    init(){
        super.init(style: .default,
                   reuseIdentifier: nil)
        setupGrayLine()
        setupReceivers()
    }
    
    
    
    let homeTeamTapReceiver = TapReceiver(team: .home)
    let awayTeamTapReceiver = TapReceiver(team: .away)
    let grayLine = UIView()
    
    func updateSelection(team : MakeEntryTeam){
        if let tableView = self.superview as? UITableView,
            let index = tableView.indexPath(for: self)?.row{
            print("game \(index) clicked, \(team)")
            if(team == .home){
                homeTeamTapReceiver.setBackgroundColor(state: .on)
                awayTeamTapReceiver.setBackgroundColor(state: .off)
            }
            else{
                homeTeamTapReceiver.setBackgroundColor(state: .off)
                awayTeamTapReceiver.setBackgroundColor(state: .on)
            }
        }
        else {
            print("error finding tableview superview")
        }
    }
    
    func setupGrayLine(){
        self.addSubview(grayLine)
        self.grayLine.translatesAutoresizingMaskIntoConstraints = false
        grayLine.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        grayLine.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        grayLine.widthAnchor.constraint(equalToConstant: 1).isActive = true
        grayLine.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupReceivers(){
        self.addSubview(homeTeamTapReceiver)
        self.addSubview(awayTeamTapReceiver)
        homeTeamTapReceiver.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        homeTeamTapReceiver.rightAnchor.constraint(equalTo: self.grayLine.leftAnchor).isActive = true
        homeTeamTapReceiver.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        homeTeamTapReceiver.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        awayTeamTapReceiver.leftAnchor.constraint(equalTo: self.grayLine.rightAnchor).isActive = true
        awayTeamTapReceiver.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        awayTeamTapReceiver.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        awayTeamTapReceiver.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    @objc func homeTeamTapReceiverTapped(){
        updateSelection(team: .home)
    }
    
    @objc func awayTeamTapReceiverTapped(){
        updateSelection(team: .away)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
