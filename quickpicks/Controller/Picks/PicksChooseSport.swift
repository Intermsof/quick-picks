//
//  PicksChooseSportViewController.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/20/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import UIKit

class PicksChooseSport: UIViewController, NavbarDelegate {
    func leaderboardClicked() {
        print("leaderboard clicked")
    }
    
    
    var customNavbar : Navbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        RealtimeModel.shared.printMe()
        self.customNavbar = Navbar(frame: (self.navigationController?.navigationBar.frame)!, string: "daily contests", option:.displayCoins, delegate: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static let sportButtonSeparation : CGFloat = 5 //Vertical separation between sport buttons
    
    func getTodaysDate() -> String{
        return "061918" //hardcoded for now
    }
    
    func getYesterdaysDate() -> String{
        return "061818" //hardcoded for now
    }
    
    var NFLContestForToday : RealtimeModel.ContestInfo? = nil
    var NBAContestForToday : RealtimeModel.ContestInfo? = nil
    var MLBContestForToday : RealtimeModel.ContestInfo? = nil
    
    override func viewWillDisappear(_ animated: Bool) {
        print("view disappearing")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view appearing")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //Default navbar does not meet our needs. So create a custom navbar
        
        //CGRect(x: 0, y: 0, width: self.view.frame.width, height: ()! + 20))
        
        self.view.addSubview(customNavbar)
        
        var last : UIButton? = nil
        
        if let NFLContestForToday = RealtimeModel.shared.getContest(ofSport : "NFL", andDate: getTodaysDate()){
            self.NFLContestForToday = NFLContestForToday
            let NFLButton = createSportButton(sportType: .NFL, gamesCount: NFLContestForToday.games.count)
            self.view.addSubview(NFLButton)
            NFLButton.topAnchor.constraint(equalTo: customNavbar.bottomAnchor, constant: 5).isActive = true
            NFLButton.addTarget(self, action: #selector(PicksChooseSport.NFLButtonClicked), for: .touchUpInside)
            last = NFLButton
        }
        
        if let NBAContestForToday = RealtimeModel.shared.getContest(ofSport : "NBA", andDate: getTodaysDate()){
            self.NBAContestForToday = NBAContestForToday
            let NBAButton = createSportButton(sportType: .NBA, gamesCount: NBAContestForToday.games.count)
            self.view.addSubview(NBAButton)
            if let last = last {
                NBAButton.topAnchor.constraint(equalTo: last.bottomAnchor, constant: 5).isActive = true
            }
            else{
                NBAButton.topAnchor.constraint(equalTo: customNavbar.bottomAnchor, constant: 5).isActive = true
            }
            last = NBAButton
            NBAButton.addTarget(self, action: #selector(PicksChooseSport.NBAButtonClicked), for: .touchUpInside)
        }
        
        if let MLBContestForToday = RealtimeModel.shared.getContest(ofSport : "MLB", andDate: getTodaysDate()){
            self.MLBContestForToday = MLBContestForToday
            let MLBButton = createSportButton(sportType: .MLB, gamesCount: MLBContestForToday.games.count)
            self.view.addSubview(MLBButton)
            if let last = last {
                MLBButton.topAnchor.constraint(equalTo: last.bottomAnchor, constant: 5).isActive = true
            }
            else{
                MLBButton.topAnchor.constraint(equalTo: customNavbar.bottomAnchor, constant: 5).isActive = true
            }
            last = MLBButton
            MLBButton.addTarget(self, action: #selector(PicksChooseSport.MLBButtonClicked), for: .touchUpInside)
        }
      //  self.navigationController?.navigationBar.layer.addSublayer(gradientLayer)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PicksChooseTeams
        let contestInfo = sender as! RealtimeModel.ContestInfo
        
        destination.contestInfo = contestInfo
    }
    
    @IBAction func NFLButtonClicked(){
        print("NFLButtonClicked")
        self.performSegue(withIdentifier: "PicksChooseSportToPicksChooseTeams", sender: NFLContestForToday)
    }
    
    @IBAction func MLBButtonClicked(){
        self.performSegue(withIdentifier: "PicksChooseSportToPicksChooseTeams", sender: MLBContestForToday)

    }
    
    @IBAction func NBAButtonClicked(){
        self.performSegue(withIdentifier: "PicksChooseSportToPicksChooseTeams", sender: NBAContestForToday)
    }
    
    
    
    static let sportButtonWidthToHeightRatio : CGFloat = 0.34127516778
    func createSportButton(sportType: UserModel.SportType, gamesCount: Int) -> UIButton{
        let height = self.view.frame.width * CGFloat(PicksChooseSport.sportButtonWidthToHeightRatio)
        
        var myImage : UIImage!
        if(sportType == .MLB){
            //Check if user made entry in MLB
            let entered = UserModel.shared.MLBData.enteredToday!
            if(entered){
                myImage = #imageLiteral(resourceName: "MLBGreen")
            }else{
                myImage = #imageLiteral(resourceName: "MLBBlack")
            }
        }
        
        if(sportType == .NBA){
            let entered = UserModel.shared.NBAData.enteredToday!
            if(entered){
                myImage = #imageLiteral(resourceName: "NBAGreen")
            }else{
                myImage = #imageLiteral(resourceName: "NBABlack")
            }
        }
        
        if(sportType == .NFL){
            let entered = UserModel.shared.NFLData.enteredToday!
            if(entered){
                myImage = #imageLiteral(resourceName: "NFLGreen")
            }else{
                myImage = #imageLiteral(resourceName: "NFLBlack")
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:self.view.frame.width,height:self.view.frame.width * PicksChooseSport.sportButtonWidthToHeightRatio), false, 2.0);
        myImage.draw(in: CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width: self.view.frame.width, height: height)))
        myImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        button.backgroundColor = UIColor(patternImage: myImage)
  
        let text = UILabel()
        
        button.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.widthAnchor.constraint(equalTo:button.widthAnchor, multiplier: 0.3).isActive = true
        text.heightAnchor.constraint(equalTo: text.widthAnchor, multiplier: 0.7).isActive = true
        
        /*
        let backgroundLayer =
        text.layer.addSublayer(<#T##layer: CALayer##CALayer#>)
        text.adjustsFontSizeToFitWidth = true
        text.font = Fonts.ScoreboardWithSize(size: 200)
        text.text = String(gamesCount)
        text.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -20).isActive = true
        text.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
    */
        
        return button
/*
        let text = UILabel()
        text.attributedText = NSAttributedString(string: String(sport.games.count));
        text.font = UIFont(name: "SCOREBOARD",size:115)
        text.textColor = UIColor.white
        text.adjustsFontSizeToFitWidth = true
        
        self.addSubview(text)
 */
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
