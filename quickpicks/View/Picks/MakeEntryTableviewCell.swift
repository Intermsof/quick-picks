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
    let game : Game
    var teamPicked : MakeEntryTeam?
    init(game: Game){
        self.game = game
        super.init(style: .default,
                   reuseIdentifier: nil)
        setupGrayLine()
        setupReceivers()
        setupLabels()
   
    }
    
    let homeTeamTapReceiver = TapReceiver(team: .home)
    let awayTeamTapReceiver = TapReceiver(team: .away)
    let grayLine = UIView()
    let homeTeamName = UILabel()
    let awayTeamName = UILabel()
    let homeTeamSpread = UILabel()
    let awayTeamSpread = UILabel()
    
    func updateSelection(team : MakeEntryTeam){
        if(team == .home){
            teamPicked = .home
            homeTeamTapReceiver.setBackgroundColor(state: .on)
            awayTeamTapReceiver.setBackgroundColor(state: .off)
            homeTeamName.textColor = UIColor.white
            homeTeamSpread.textColor = UIColor.white
            awayTeamName.textColor = Colors.QPGrey
            awayTeamSpread.textColor = Colors.QPGrey
        }
        else{
            teamPicked = .away
            homeTeamTapReceiver.setBackgroundColor(state: .off)
            awayTeamTapReceiver.setBackgroundColor(state: .on)
            homeTeamName.textColor = Colors.QPGrey
            homeTeamSpread.textColor = Colors.QPGrey
            awayTeamName.textColor = UIColor.white
            awayTeamSpread.textColor = UIColor.white
        }
    }
    
    func setupLabels(){
        homeTeamName.textColor = Colors.QPGrey
        homeTeamSpread.textColor = Colors.QPGrey
        awayTeamName.textColor = Colors.QPGrey
        awayTeamSpread.textColor = Colors.QPGrey
        
        homeTeamName.text = game.homeTeamName
        awayTeamName.text = game.awayTeamName
        homeTeamSpread.text = String(game.spread)
        awayTeamSpread.text = String(-game.spread)
        
        homeTeamName.translatesAutoresizingMaskIntoConstraints = false
        awayTeamName.translatesAutoresizingMaskIntoConstraints = false
        homeTeamSpread.translatesAutoresizingMaskIntoConstraints = false
        awayTeamSpread.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(homeTeamName)
        self.addSubview(awayTeamName)
        self.addSubview(homeTeamSpread)
        self.addSubview(awayTeamSpread)
        
        homeTeamName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        awayTeamName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        homeTeamSpread.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        awayTeamSpread.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        homeTeamName.centerXAnchor.constraint(equalTo: self.leftAnchor, constant: 0.15 * self.frame.width).isActive = true
        homeTeamSpread.centerXAnchor.constraint(equalTo: self.leftAnchor, constant: 0.40 * self.frame.width).isActive = true
        awayTeamName.centerXAnchor.constraint(equalTo: self.rightAnchor, constant: -0.40 * self.frame.width).isActive = true
        awayTeamSpread.centerXAnchor.constraint(equalTo: self.rightAnchor, constant: -0.15 * self.frame.width).isActive = true
        
        let font = Fonts.OswaldWithSize(size: 25)
        homeTeamName.font = font
        awayTeamName.font = font
        homeTeamSpread.font = font
        awayTeamSpread.font = font
    }
    
    func setupGrayLine(){
        self.addSubview(grayLine)
        grayLine.backgroundColor = UIColor.blue
        self.grayLine.translatesAutoresizingMaskIntoConstraints = false
        grayLine.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        grayLine.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        grayLine.widthAnchor.constraint(equalToConstant: 0.4).isActive = true
        grayLine.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupReceivers(){
        print("setting up receivers")
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
    
    class TapReceiver : UIView {
        let team : MakeEntryTeam
        let PADDING : CGFloat = 2.5
        let backgroundView = UIView()
        
        init(team: MakeEntryTeam){
            self.team = team
            super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.translatesAutoresizingMaskIntoConstraints = false
            setupBackground()
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
            self.addGestureRecognizer(tapRecognizer)
            self.isUserInteractionEnabled = true
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
}
