//
//  PicksChooseTeams.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/30/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import UIKit

protocol NavbarDelegate {
    func leaderboardClicked() //name is misnomer. Only used to be consisten with what's used in navbar. See navbar
}

class PicksChooseTeams: UIViewController, UITableViewDelegate, UITableViewDataSource, NavbarDelegate, FirebaseCallable {
    func notifySuccess() {
        print("saved picks")
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func notifyFailure() {
        print("Got fucked")
    }
    
    func leaderboardClicked() {
        print("Hi")
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    var contestInfo : RealtimeModel.ContestInfo!
    var customNavbar : Navbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavbar = Navbar(frame: (self.navigationController?.navigationBar.frame)!, string: "\(contestInfo.sportName.lowercased()) picks", option: .displaySport, delegate: self)
        self.view.addSubview(customNavbar)
        // Do any additional setup after loading the view.
    }

    var scoreEnter : ScoreEnter!
    var submitButton : UIButton!
    var submitString : NSAttributedString!
    var doneString : NSAttributedString!
    var infoButton : UIImageView!
    var table : UITableView!
    override func viewWillAppear(_ animated: Bool) {
        /*
        let label = UILabel()
        label.attributedText = NSAttributedString(string: getLabel(),
                                                  attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 25),
                                                               NSAttributedStringKey.kern: 1.0])
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: customNavbar.bottomAnchor, constant: 10).isActive = true
        */
        let scoreEnterMargin : CGFloat = 20
        
        scoreEnter = ScoreEnter()
        scoreEnter.attributedPlaceholder = NSAttributedString(string: "last game's score", attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 20)
            ,NSAttributedStringKey.foregroundColor : UIColor.white])
        scoreEnter.backgroundColor = Colors.QPGrey
        scoreEnter.borderStyle = .roundedRect
        self.view.addSubview(scoreEnter)
        scoreEnter.translatesAutoresizingMaskIntoConstraints = false
        scoreEnter.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scoreEnterMargin).isActive = true
        scoreEnter.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.07).isActive = true
        scoreEnter.topAnchor.constraint(equalTo: customNavbar.bottomAnchor, constant: scoreEnterMargin).isActive = true
        scoreEnter.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.7).isActive = true
        scoreEnter.keyboardType = .numberPad
        scoreEnter.defaultTextAttributes = [NSAttributedStringKey.font.rawValue : Fonts.CollegeBoyWithSize(size: 20), NSAttributedStringKey.foregroundColor.rawValue : UIColor.white]
        scoreEnter.textAlignment = .center
        
        
        infoButton = UIImageView(image: #imageLiteral(resourceName: "Info"))
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(infoButton)
        infoButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        infoButton.centerYAnchor.constraint(equalTo: scoreEnter.centerYAnchor).isActive = true
        infoButton.widthAnchor.constraint(equalTo: scoreEnter.heightAnchor).isActive = true
        infoButton.heightAnchor.constraint(equalTo: scoreEnter.heightAnchor).isActive = true
        infoButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PicksChooseTeams.infoButtonClicked)))
        infoButton.isUserInteractionEnabled = true
        
        submitString = NSAttributedString(string: "submit", attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 25)
            ,NSAttributedStringKey.foregroundColor : Colors.QPRed])
        doneString = NSAttributedString(string: "done", attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 25)
            ,NSAttributedStringKey.foregroundColor : Colors.QPRed])
        
        let submitButtonMargin : CGFloat = 10.0
        submitButton = UIButton()
        self.view.addSubview(submitButton)
        //submitButton.layer.borderWidth = 1
        //submitButton.layer.borderColor = Colors.QPRed.cgColor
        submitButton.backgroundColor = UIColor.white
        submitButton.layer.cornerRadius = 2
        submitButton.setAttributedTitle(submitString, for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false

        submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -submitButtonMargin).isActive = true
        submitButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: customNavbar.bottomAnchor, constant: -submitButtonMargin).isActive = true
        submitButton.topAnchor.constraint(equalTo: customNavbar.topAnchor, constant: 20.0 + submitButtonMargin).isActive = true
        submitButton.addTarget(self, action: #selector(PicksChooseTeams.submitClicked), for: .touchUpInside)
        
        table = UITableView()
        self.view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = Colors.QPGrey
        table.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        table.topAnchor.constraint(equalTo: scoreEnter.bottomAnchor, constant: scoreEnterMargin).isActive = true
        
        table.delegate = self
        table.dataSource = self
        table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let middleLine = UIView()
        self.view.addSubview(middleLine)
        middleLine.backgroundColor = Colors.QPGrey
        middleLine.translatesAutoresizingMaskIntoConstraints = false
        middleLine.topAnchor.constraint(equalTo: table.topAnchor).isActive = true
        middleLine.bottomAnchor.constraint(equalTo: table.bottomAnchor).isActive = true
        middleLine.centerXAnchor.constraint(equalTo: table.centerXAnchor).isActive = true
        middleLine.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(PicksChooseTeams.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PicksChooseTeams.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    var keyboardOn = false
    @objc func keyboardWillShow(_ sender : NSNotification){
        print("in keyboardwillshow")
        submitButton.setAttributedTitle(doneString, for: .normal)
        keyboardOn = true
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification){
        print("in keyboard hide")
        submitButton.setAttributedTitle(submitString, for: .normal)
        keyboardOn = false
    }
    
    @IBAction func submitClicked(){
        if(keyboardOn){
            scoreEnter.resignFirstResponder()
        }else{
            print("save picks now")
            if(validate()){
                FirebaseManager.shared.updatePicks(sport: contestInfo.sportName, controller: self)
            }else{
                print("validation failed")
            }
        }
    }
    
    
    class ScoreEnter : UITextField {
        
        static let textInsetAmount : CGFloat = 10.0
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: ScoreEnter.textInsetAmount, dy: ScoreEnter.textInsetAmount)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: ScoreEnter.textInsetAmount, dy: ScoreEnter.textInsetAmount)
        }
    }
    
    func createDetailInfo() -> (UIView, NSLayoutConstraint){
        let detailInfo = UIView()
        detailInfo.backgroundColor = UIColor.white
        detailInfo.layer.borderWidth = 1.0
        detailInfo.layer.borderColor = Colors.QPGreenLight.cgColor
        detailInfo.layer.shadowColor = UIColor.black.cgColor
        detailInfo.layer.shadowRadius = 4.0
        let positionsInfo = contestInfo.positionsInfo
        let pointsInfo = contestInfo.pointsInfo
        
        let font = Fonts.OswaldWithSize(size: 25)
        let margin : CGFloat = 20
        var last : UILabel? = nil
        for position in positionsInfo {
            let label = UILabel()
            detailInfo.addSubview(label)
            label.text = position
            label.font = font
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leftAnchor.constraint(equalTo: detailInfo.leftAnchor, constant : margin).isActive = true
            if let last = last {
                label.topAnchor.constraint(equalTo: last.bottomAnchor, constant: margin).isActive = true
            }
            else{
                label.topAnchor.constraint(equalTo: detailInfo.topAnchor, constant: margin).isActive = true
            }
            last = label
        }
        
        var pointLast : UILabel? = nil
        for point in pointsInfo {
            let label = UILabel()
            label.text = String(point)
            label.font = font
            detailInfo.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.rightAnchor.constraint(equalTo: detailInfo.rightAnchor, constant: -margin).isActive = true
            if let last = pointLast {
                label.topAnchor.constraint(equalTo: last.bottomAnchor, constant: margin).isActive = true
            }
            else {
                label.topAnchor.constraint(equalTo: detailInfo.topAnchor, constant: margin).isActive = true
            }
            pointLast = label
        }
        
        let bottomAnchor = detailInfo.bottomAnchor.constraint(equalTo: pointLast!.bottomAnchor, constant: margin)
        bottomAnchor.isActive = true
        detailInfo.isHidden = true
        return (detailInfo, bottomAnchor)
    }
    
    var detailInfo : UIView? = nil
    var detailInfoWidth : CGFloat!
    var detailInfoHeight : CGFloat!
    var leftConstraint : NSLayoutConstraint!
    var bottomConstraint : NSLayoutConstraint!
    var detailInfoShown = false
    @IBAction func infoButtonClicked(){
        print("info button clicked")
        if (detailInfo == nil){
            let result = createDetailInfo()
            detailInfo = result.0
            self.view.addSubview(detailInfo!)
            detailInfo!.translatesAutoresizingMaskIntoConstraints = false
            leftConstraint = detailInfo!.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width * 0.15)
            leftConstraint.isActive = true
            bottomConstraint = result.1
            detailInfo!.rightAnchor.constraint(equalTo: infoButton.leftAnchor).isActive = true
            detailInfo!.topAnchor.constraint(equalTo: infoButton.centerYAnchor).isActive = true
            detailInfo!.layoutIfNeeded()
            detailInfoWidth = detailInfo!.frame.width
            detailInfoHeight = detailInfo!.frame.height
            //set up for appear animation
            self.leftConstraint.constant += self.detailInfoWidth
            self.detailInfo!.setNeedsUpdateConstraints()
            self.detailInfo!.layoutIfNeeded()
            self.detailInfo?.isHidden = true
            self.detailInfo?.alpha = 0.0
            for subview in self.detailInfo!.subviews {
                subview.alpha = 0.0
            }
            
        }
        print("\(detailInfoWidth), \(detailInfoHeight)")
        if(detailInfoShown){
            hideDetailInfo()
        }
        else{
            showDetailInfo()
        }
        
        
    }
    
    func showDetailInfo(){
        table.isUserInteractionEnabled = false
        detailInfoShown = true
        detailInfo?.isHidden = false
        leftConstraint.constant -= detailInfoWidth
        //bottomConstraint.constant += detailInfoHeight
        self.detailInfo!.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5, animations: {
            self.detailInfo?.alpha = 1.0
            for subview in self.detailInfo!.subviews {
                subview.alpha = 1.0
            }
            
            self.detailInfo!.layoutIfNeeded()
        })
    }
    
    func hideDetailInfo(){
        detailInfoShown = false
        table.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.5, animations: {
            self.detailInfo?.alpha = 0.0
            for subview in self.detailInfo!.subviews {
                subview.alpha = 0.0
            }
            
        },completion: { _ in
            self.detailInfo!.setNeedsUpdateConstraints()
            self.detailInfo!.layoutIfNeeded()
            self.detailInfo?.isHidden = true
            self.leftConstraint.constant += self.detailInfoWidth
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    //Only call this if not in edit picks mode.
    func getLabel() ->String {
        switch contestInfo!.sportName {
        case "NFL":
            return "national football league"
        case "NBA":
            return "national basketball association"
        case "MLB":
            return "major league baseball"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contestInfo.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.allowsSelection = false
        let retVal = UITableViewCell()
        
        let tapReceiverHome = TapReceiver()
        let tapReceiverAway = TapReceiver()
        
        retVal.addSubview(tapReceiverHome)
        retVal.addSubview(tapReceiverAway)
        
        tapReceiverHome.translatesAutoresizingMaskIntoConstraints = false
        tapReceiverAway.translatesAutoresizingMaskIntoConstraints = false
        let inset : CGFloat = 4
        tapReceiverHome.topAnchor.constraint(equalTo: retVal.topAnchor, constant: inset).isActive = true
        tapReceiverAway.topAnchor.constraint(equalTo: retVal.topAnchor, constant: inset).isActive = true
        
        tapReceiverHome.bottomAnchor.constraint(equalTo: retVal.bottomAnchor, constant: -inset).isActive = true
        tapReceiverAway.bottomAnchor.constraint(equalTo: retVal.bottomAnchor, constant: -inset).isActive = true
        
        tapReceiverHome.leftAnchor.constraint(equalTo: retVal.leftAnchor, constant: inset).isActive = true
        tapReceiverAway.rightAnchor.constraint(equalTo: retVal.rightAnchor, constant: -inset).isActive = true
        
        tapReceiverHome.rightAnchor.constraint(equalTo: retVal.centerXAnchor, constant: -inset).isActive = true
        tapReceiverAway.leftAnchor.constraint(equalTo: retVal.centerXAnchor, constant: inset).isActive = true
        
        tapReceiverHome.addTarget(self, action: #selector(PicksChooseTeams.homeReceiverTapped(sender:)), for: .touchUpInside)
        tapReceiverAway.addTarget(self, action: #selector(PicksChooseTeams.awayReceiverTapped(sender:)), for: .touchUpInside)

        
        let font = Fonts.OswaldWithSize(size: 25)
        
        let homeName = UILabel()
        homeName.font = font
        homeName.text = contestInfo.games[indexPath.row].homeTeamName.uppercased()
        homeName.textColor = Colors.QPGrey
        
        let awayName = UILabel()
        awayName.font = font
        awayName.text = contestInfo.games[indexPath.row].awayTeamName.uppercased()
        awayName.textColor = Colors.QPGrey
        
        let homeSpread = UILabel()
        homeSpread.font = font
        homeSpread.text = String(contestInfo.games[indexPath.row].homeSpread)
        homeSpread.textColor = Colors.QPGrey
        
        let awaySpread = UILabel()
        awaySpread.font = font
        awaySpread.text = String(-contestInfo.games[indexPath.row].homeSpread)
        awaySpread.textColor = Colors.QPGrey
        
        tapReceiverHome.addSubview(homeName)
        tapReceiverAway.addSubview(awayName)
        tapReceiverHome.addSubview(homeSpread)
        tapReceiverAway.addSubview(awaySpread)
        
        homeName.translatesAutoresizingMaskIntoConstraints = false
        awayName.translatesAutoresizingMaskIntoConstraints = false
        awaySpread.translatesAutoresizingMaskIntoConstraints = false
        homeSpread.translatesAutoresizingMaskIntoConstraints = false
        
        homeName.centerYAnchor.constraint(equalTo: retVal.centerYAnchor).isActive = true
        awayName.centerYAnchor.constraint(equalTo: retVal.centerYAnchor).isActive = true
        awaySpread.centerYAnchor.constraint(equalTo: retVal.centerYAnchor).isActive = true
        homeSpread.centerYAnchor.constraint(equalTo: retVal.centerYAnchor).isActive = true
        
        homeName.centerXAnchor.constraint(equalTo: retVal.leftAnchor, constant: self.view.frame.width * 0.125).isActive = true
        homeSpread.centerXAnchor.constraint(equalTo: retVal.leftAnchor, constant: self.view.frame.width * 0.375).isActive = true
        awaySpread.centerXAnchor.constraint(equalTo: retVal.leftAnchor, constant: self.view.frame.width * 0.625).isActive = true
        awayName.centerXAnchor.constraint(equalTo: retVal.leftAnchor, constant: self.view.frame.width * 0.875).isActive = true
        
        
        tapReceiverHome.row = indexPath.row
        tapReceiverHome.active = false
        tapReceiverHome.textOne = homeName
        tapReceiverHome.textTwo = homeSpread
        
        tapReceiverAway.row = indexPath.row
        tapReceiverAway.other = tapReceiverHome
        tapReceiverAway.active = false
        tapReceiverAway.textOne = awayName
        tapReceiverAway.textTwo = awaySpread
        
        tapReceiverHome.other = tapReceiverAway
        
        let line = CALayer()
        line.frame = CGRect(x: 0, y: retVal.frame.height - 1, width: 40, height: 1)

        switch contestInfo.sportName {
        case "NFL":
            if(UserModel.shared.NFLData.todaysPicks[indexPath.row] == 0){
                turnOn(sender: tapReceiverHome)
            }
            if(UserModel.shared.NFLData.todaysPicks[indexPath.row] == 1){
                turnOn(sender: tapReceiverAway)
            }
        case "NBA":
            if(UserModel.shared.NBAData.todaysPicks[indexPath.row] == 0){
                turnOn(sender: tapReceiverHome)
            }
            if(UserModel.shared.NBAData.todaysPicks[indexPath.row] == 1){
                turnOn(sender: tapReceiverAway)
            }
        case "MLB":
            if(UserModel.shared.MLBData.todaysPicks[indexPath.row] == 0){
                turnOn(sender: tapReceiverHome)
            }
            if(UserModel.shared.MLBData.todaysPicks[indexPath.row] == 1){
                turnOn(sender: tapReceiverAway)
            }
        default:
            return retVal //dummy
        }
        return retVal
    }
    
    let picksCellPercentage : CGFloat = 0.07
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * picksCellPercentage
    }

    func turnOff(sender: TapReceiver){
        sender.active = false
        sender.backgroundColor = UIColor.white
        sender.textOne.textColor = Colors.QPGrey
        sender.textTwo.textColor = Colors.QPGrey
    }
    func turnOn(sender: TapReceiver){
        sender.active = true
        sender.backgroundColor = Colors.QPGreenDark
        sender.textOne.textColor = UIColor.white
        sender.textTwo.textColor = UIColor.white

        turnOff(sender: sender.other)
    }

    @IBAction func homeReceiverTapped(sender: TapReceiver){
        print("homeReceiver Clicked \(sender.row)")
        switch contestInfo.sportName {
        case "NFL":
            UserModel.shared.NFLData.enteredToday = true
            UserModel.shared.NFLData.todaysPicks[sender.row] = 0
        case "NBA":
            UserModel.shared.NBAData.enteredToday = true
            UserModel.shared.NBAData.todaysPicks[sender.row] = 0
        case "MLB":
            UserModel.shared.MLBData.enteredToday = true
            UserModel.shared.MLBData.todaysPicks[sender.row] = 0
        default:
            return
        }
        
        if(!sender.active){
            turnOn(sender: sender)
        }
        
    }
    
    @IBAction func awayReceiverTapped(sender: TapReceiver){
        print("awayReceiver Clicked \(sender.row)")
        switch contestInfo.sportName {
        case "NFL":
            UserModel.shared.NFLData.enteredToday = true
            UserModel.shared.NFLData.todaysPicks[sender.row] = 1
        case "NBA":
            UserModel.shared.NBAData.enteredToday = true
            UserModel.shared.NBAData.todaysPicks[sender.row] = 1
        case "MLB":
            UserModel.shared.MLBData.enteredToday = true
            UserModel.shared.MLBData.todaysPicks[sender.row] = 1
        default:
            return
        }
        
        if(!sender.active){
            turnOn(sender: sender)
        }
    }
    
    func validate() -> Bool {
        return true
        if(scoreEnter.text == nil || scoreEnter.text!.isEmpty){
            return false
        }
        if(Int(scoreEnter.text!)! > 200){
            return false
        }
        switch contestInfo.sportName {
        case "NFL":
            return !UserModel.shared.NFLData.todaysPicks.contains(-1)
        case "NBA":
            return !UserModel.shared.NBAData.todaysPicks.contains(-1)
        case "MLB":
            return !UserModel.shared.MLBData.todaysPicks.contains(-1)
        default:
            return false //Dummy
        }
    }
    
    class TapReceiver : UIButton {
        var row : Int!
        var active : Bool = false
        var other : TapReceiver!
        var textOne : UILabel!
        var textTwo : UILabel!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
