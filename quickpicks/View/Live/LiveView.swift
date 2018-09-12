//
//  File.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 9/4/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class LiveView : NavViewContainer {
    let SUB_TABBAR_HEIGHT : CGFloat = 35
    let SLIDER_HEIGHT : CGFloat = 2.5
    let leftBar = UIButton()
    let middleBar = UIButton()
    let rightBar = UIButton()
    let slider = UIView()
    let barFont = Fonts.CollegeBoyWithSize(size: 20)
    let liveGamesTable = LiveGamesTable(sport: Sport.sports[0]) //Default to the first sport for now
    let myPicksTable = MyPicksTable(sport: Sport.sports[0], contestEntry: User.shared.NFLcontestEntry)
    let rankingsTable = RankingsTable(sport: Sport.sports[0]) //Default to the first sport for now
    
    var sliderConstraint : NSLayoutConstraint!

    
    init(navBarDelegate: NavBarDelegate, liveViewDelegate: LiveViewDelegate){
        super.init(navBarDelegate : navBarDelegate)
        
        include(leftBar)
        include(middleBar)
        include(rightBar)
        include(slider)
        include(liveGamesTable)
        include(myPicksTable)
        include(rankingsTable)
        
        setupLeftBar()
        setupMiddleBar()
        setupRightBar()
        setupSlider()
        setupLiveGamesTable()
        setupMyPicksTable()
        setupRankingsTable()
    }
    
    func setupMyPicksTable(){
        placeBelow(source: myPicksTable, target: leftBar, padding: 0)
        bindLeft(myPicksTable, target: self, 0)
        bindRight(myPicksTable, target: self, 0)
        bindBottom(myPicksTable, target: self, 0)
    }
    
    func setupRankingsTable(){
        placeBelow(source: rankingsTable, target: leftBar, padding: 0)
        bindLeft(rankingsTable, target: self, 0)
        bindRight(rankingsTable, target: self, 0)
        bindBottom(rankingsTable, target: self, 0)
        rankingsTable.isHidden = true
    }
    
    func setupLiveGamesTable(){
        placeBelow(source: liveGamesTable, target: leftBar, padding: 0)
        bindLeft(liveGamesTable, target: self, 0)
        bindRight(liveGamesTable, target: self, 0)
        bindBottom(liveGamesTable, target: self, 0)
        liveGamesTable.isHidden = true
    }
    
    func setupLeftBar(){
        placeBelow(source: leftBar, target: navbar, padding: 0)
        bindLeft(leftBar, target: self, 0)
        bindWidth(leftBar, target: self, 0.3333)
        leftBar.heightAnchor.constraint(equalToConstant: SUB_TABBAR_HEIGHT).isActive = true
        leftBar.backgroundColor = UIColor.black
        leftBar.setTitle("rankings", for: .normal)
        leftBar.setTitleColor(UIColor.lightGray, for: .normal)
        leftBar.titleLabel?.font = barFont
        leftBar.addTarget(self, action: #selector(self.leftBarTapped), for: .touchUpInside)
    }
    
    func setupMiddleBar(){
        placeBelow(source: middleBar, target: navbar, padding: 0)
        bindWidth(middleBar, target: self, 0.3333)
        placeRight(source: middleBar, target: leftBar, padding: 0)
        middleBar.heightAnchor.constraint(equalToConstant: SUB_TABBAR_HEIGHT).isActive = true
        middleBar.backgroundColor = UIColor.black
        middleBar.setTitle("my picks", for: .normal)
        middleBar.setTitleColor(Colors.QPYellow, for: .normal)
        middleBar.titleLabel?.font = barFont
        middleBar.addTarget(self, action: #selector(self.middleBarTapped), for: .touchUpInside)
    }
    
    func setupRightBar(){
        placeBelow(source: rightBar, target: navbar, padding: 0)
        placeRight(source: rightBar, target: middleBar, padding: 0)
        bindRight(rightBar, target: self, 0)
        rightBar.heightAnchor.constraint(equalToConstant: SUB_TABBAR_HEIGHT).isActive = true
        rightBar.backgroundColor = UIColor.black
        rightBar.setTitle("live games", for: .normal)
        rightBar.setTitleColor(UIColor.lightGray, for: .normal)
        rightBar.titleLabel?.font = barFont
        rightBar.addTarget(self, action: #selector(self.rightBarTapped), for: .touchUpInside)
    }
    
    @IBAction func leftBarTapped(){
        moveSlider(to: 0)
        leftBar.setTitleColor(Colors.QPYellow, for: .normal)
        middleBar.setTitleColor(UIColor.lightGray, for: .normal)
        rightBar.setTitleColor(UIColor.lightGray, for: .normal)
        
        if(rankingsTable.isHidden){
            UIView.animate(withDuration: 0.15) {
                self.rankingsTable.isHidden = false
                self.myPicksTable.isHidden = true
                self.liveGamesTable.isHidden = true
            }
        }
    }
    
    @IBAction func middleBarTapped(){
        moveSlider(to: self.frame.width * 0.3333)
        leftBar.setTitleColor(UIColor.lightGray, for: .normal)
        middleBar.setTitleColor(Colors.QPYellow, for: .normal)
        rightBar.setTitleColor(UIColor.lightGray, for: .normal)
        
        if(myPicksTable.isHidden){
            UIView.animate(withDuration: 0.15) {
                self.rankingsTable.isHidden = true
                self.myPicksTable.isHidden = false
                self.liveGamesTable.isHidden = true
            }
        }
    }
    
    @IBAction func rightBarTapped(){
        moveSlider(to: self.frame.width * 0.6666)
        leftBar.setTitleColor(UIColor.lightGray, for: .normal)
        middleBar.setTitleColor(UIColor.lightGray, for: .normal)
        rightBar.setTitleColor(Colors.QPYellow, for: .normal)
        
        if(liveGamesTable.isHidden){
            UIView.animate(withDuration: 0.15) {
                self.rankingsTable.isHidden = true
                self.myPicksTable.isHidden = true
                self.liveGamesTable.isHidden = false
            }
        }
    }
    
    func moveSlider(to: CGFloat){
        UIView.setAnimationCurve(.easeInOut)
        UIView.animate(withDuration: 0.15) {
            self.sliderConstraint.constant = to
            self.layoutIfNeeded()
        }
    }
    
    func setupSlider(){
        bindBottom(slider, target: rightBar, 0)
        slider.heightAnchor.constraint(equalToConstant: SLIDER_HEIGHT).isActive = true
        bindWidth(slider, target: self, 0.3333)
        slider.backgroundColor = Colors.QPYellow
        sliderConstraint = slider.leftAnchor.constraint(equalTo: self.leftAnchor)
        sliderConstraint.isActive = true
    }
    
    override func addTo(_ controller: UIViewController) {
        super.addTo(controller)
        self.layoutIfNeeded()
        self.sliderConstraint.constant = self.frame.width * 0.3333
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
