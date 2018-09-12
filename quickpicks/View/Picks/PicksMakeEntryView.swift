//
//  PicksMakeEntryView.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/27/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class PicksMakeEntryView : NavViewContainer, UITableViewDataSource, UITableViewDelegate {
    let makeEntryTable = UITableView()
    let enterScoreField = InsetTextfield()
    let infoButton = UIImageView(image: #imageLiteral(resourceName: "Info"))
    let submitButton = UIButton()
    let picksMakeEntryViewDelegate : PicksMakeEntryViewDelegate
    
    var existingContestEntry : ContestEntry?
    
    let ENTER_SCORE_MARGIN : CGFloat = 20
    let ENTER_SCORE_HEIGHT : CGFloat = 40
    
    init(navBarDelegate : NavBarDelegate, picksMakeEntryViewDelegate : PicksMakeEntryViewDelegate){
        self.picksMakeEntryViewDelegate = picksMakeEntryViewDelegate
        super.init(navBarDelegate : navBarDelegate)
        include(makeEntryTable)
        include(enterScoreField)
        include(infoButton)
        include(submitButton)
        
        setupEnterScoreField()
        setupInfoButton()
        setupMakeEntrytable()
        setupSubmitButton()
        
        if(Sport.isNFLPicked()){
            existingContestEntry = User.shared.NFLcontestEntry
            if let exist = existingContestEntry {
                enterScoreField.text = String(exist.lastGameScore)
            }
        }
        else if(Sport.isNBAPicked()){
            existingContestEntry = User.shared.NBAcontestEntry
            if let exist = existingContestEntry {
                enterScoreField.text = String(exist.lastGameScore)
            }
        }
        else if(Sport.isMLBPicked()){
            existingContestEntry = User.shared.MLBcontestEntry
            if let exist = existingContestEntry {
                enterScoreField.text = String(exist.lastGameScore)
            }
        }
    }
    
    var doneString : NSAttributedString!
    var submitString : NSAttributedString!
    var keyboardShown : Bool = false
    func setupSubmitButton(){
        submitString = NSAttributedString(string: "submit", attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 25)
            ,NSAttributedStringKey.foregroundColor : Colors.QPRed])
        doneString = NSAttributedString(string: "done", attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 25)
            ,NSAttributedStringKey.foregroundColor : Colors.QPRed])
        
        let submitButtonMargin : CGFloat = 10.0
        
        //submitButton.layer.borderWidth = 1
        //submitButton.layer.borderColor = Colors.QPRed.cgColor
        submitButton.backgroundColor = UIColor.white
        submitButton.layer.cornerRadius = 2
        submitButton.setAttributedTitle(submitString, for: .normal)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        submitButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -submitButtonMargin).isActive = true
        submitButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: navbar.bottomAnchor, constant: -submitButtonMargin).isActive = true
        submitButton.topAnchor.constraint(equalTo: navbar.topAnchor, constant: 20.0 + submitButtonMargin).isActive = true
        submitButton.addTarget(self, action: #selector(self.submitClicked), for: .touchUpInside)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ : Any){
        submitButton.setAttributedTitle(doneString, for: .normal)
        keyboardShown = true
    }
    
    @objc func keyboardWillHide(_ : Any){
        submitButton.setAttributedTitle(submitString, for: .normal)
        keyboardShown = false
    }
    
    @objc func submitClicked(){
        
        if(keyboardShown){
            enterScoreField.resignFirstResponder()
            return
        }
        
        print("submit clicked")
        let rows = makeEntryTable.numberOfRows(inSection: 0)
        var picks = [Int]()
        for index in 0..<rows{
            let cell = makeEntryTable.cellForRow(at: IndexPath(row: index, section: 0)) as! MakeEntryTableviewCell
            
            if(cell.teamPicked == .home){
                picks.append(0)
            }
            else{
                picks.append(1)
            }
        }
        let lastGameScore = Int(enterScoreField.text!)!
        
        let contestEntry = ContestEntry(id: nil, picks: picks, contest: Sport.selectedSport!.currentContest.id, date: Sport.selectedSport!.currentContest.date, position: -1, lastGameScore: lastGameScore)
        
        picksMakeEntryViewDelegate.submitResults(contestEntry: contestEntry)
    }
    
    func setupEnterScoreField(){
        enterScoreField.attributedPlaceholder = NSAttributedString(string: "last game's final score", attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 20)
            ,NSAttributedStringKey.foregroundColor : UIColor.white])
        
        enterScoreField.defaultTextAttributes = [NSAttributedStringKey.font.rawValue : Fonts.CollegeBoyWithSize(size: 20), NSAttributedStringKey.foregroundColor.rawValue : UIColor.white]
        
        enterScoreField.backgroundColor = Colors.QPGrey
        enterScoreField.borderStyle = .roundedRect

        placeBelow(source: enterScoreField, target: navbar, padding: ENTER_SCORE_MARGIN)
        bindLeft(enterScoreField, target: self, ENTER_SCORE_MARGIN)
        enterScoreField.heightAnchor.constraint(equalToConstant: ENTER_SCORE_HEIGHT).isActive = true
        bindWidth(enterScoreField, target: self, 0.7)
        
        enterScoreField.keyboardType = .numberPad
        enterScoreField.textAlignment = .center
    }
    
    func setupInfoButton(){
        bindRight(infoButton, target: self, ENTER_SCORE_MARGIN)
        infoButton.centerYAnchor.constraint(equalTo: enterScoreField.centerYAnchor).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: ENTER_SCORE_HEIGHT).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: ENTER_SCORE_HEIGHT).isActive = true
        infoButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.infoButtonClicked)))
        infoButton.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Sport.selectedSport!.currentContest.gameIDs.count)
        print(Sport.selectedSport!.id)
        print(Sport.selectedSport!.currentContest.id)
        print(Sport.selectedSport!.currentContest.games)
        return Sport.selectedSport!.currentContest.gameIDs.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.allowsSelection = false
        let gameID = Sport.selectedSport!.currentContest.gameIDs[indexPath.row]
        let game = Sport.selectedSport!.currentContest.games[gameID]
        let retVal = MakeEntryTableviewCell(game: game!)
        retVal.awayTeamTapReceiver.setBackgroundColor(state: .off)
        retVal.homeTeamTapReceiver.setBackgroundColor(state: .off)
        
        if let entry = existingContestEntry{
            let pick = entry.picks[indexPath.row]
            if(pick == 0){
                retVal.updateSelection(team: .home)
            }
            else{
                retVal.updateSelection(team: .away)
            }
        }
        return retVal
    }
    
    func setupMakeEntrytable(){
        bindLeft(makeEntryTable, target: self, 0)
        bindRight(makeEntryTable, target: self, 0)
        placeBelow(source: makeEntryTable, target: enterScoreField, padding: ENTER_SCORE_MARGIN)
        bindBottom(makeEntryTable, target: self, 0)
        
        makeEntryTable.dataSource = self
        makeEntryTable.delegate = self
    }
    
    
    var detailInfo : UIView? = nil
    var detailInfoWidth : CGFloat!
    var detailInfoHeight : CGFloat!
    var leftConstraint : NSLayoutConstraint!
    var bottomConstraint : NSLayoutConstraint!
    var detailInfoShown = false
    
    @IBAction func infoButtonClicked(){
        
        print("info button clicked")
//        if (detailInfo == nil){
//            let result = createDetailInfo()
//            detailInfo = result.0
//            self.view.addSubview(detailInfo!)
//            detailInfo!.translatesAutoresizingMaskIntoConstraints = false
//            leftConstraint = detailInfo!.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width * 0.15)
//            leftConstraint.isActive = true
//            bottomConstraint = result.1
//            detailInfo!.rightAnchor.constraint(equalTo: infoButton.leftAnchor).isActive = true
//            detailInfo!.topAnchor.constraint(equalTo: infoButton.centerYAnchor).isActive = true
//            detailInfo!.layoutIfNeeded()
//            detailInfoWidth = detailInfo!.frame.width
//            detailInfoHeight = detailInfo!.frame.height
//            //set up for appear animation
//            self.leftConstraint.constant += self.detailInfoWidth
//            self.detailInfo!.setNeedsUpdateConstraints()
//            self.detailInfo!.layoutIfNeeded()
//            self.detailInfo?.isHidden = true
//            self.detailInfo?.alpha = 0.0
//            for subview in self.detailInfo!.subviews {
//                subview.alpha = 0.0
//            }
//
//        }
//        print("\(detailInfoWidth), \(detailInfoHeight)")
//        if(detailInfoShown){
//            hideDetailInfo()
//        }
//        else{
//            showDetailInfo()
//        }
    }
}
