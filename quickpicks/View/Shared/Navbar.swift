//
//  Navbar.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/25/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import UIKit

//the so called "leaderboardbutton" is a misnomer. It does various functionalities depending on the NavbarOption passed in.
class Navbar: UIView {
    enum NavbarOptions {
        case displayCoins
        case displaySport //For the PicksChooseTeams page
    }
    //Note about sizing of navbar. We pass the frame of the standard UINavbar into the initializer. Then, we add the safeareaoffset to the height. In addition, we want our navbar to be slightly taller than the standard UINavbar, so we add extraHeight.
    static let safeAreaOffset : CGFloat = 20.0
    static let extraHeight : CGFloat = 10.0
    
    static let verticalWhiteLineWidth : CGFloat = 1.0
    let option : NavbarOptions
    
    //let delegate : NavbarDelegate
    
    init(frame: CGRect, string: String, option: NavbarOptions){
        self.option = option
        let contentHeight = frame.height
        let navbarFrame = CGRect(x: 0, y: 0, width: frame.width, height: contentHeight + Navbar.safeAreaOffset + Navbar.extraHeight)
       // self.delegate = delegate
        super.init(frame: navbarFrame)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = navbarFrame
        gradientLayer.colors = [UIColor(red: 0.43137255, green: 0.74509804, blue: 0.27058824, alpha:1.0).cgColor, UIColor(red:0.55294118, green: 0.77647059, blue:0.24705882, alpha:1.0).cgColor]
        
        self.layer.addSublayer(gradientLayer)
        
        let contentInset : CGFloat = 17.0
        let button = UIImageView(frame: CGRect(x: contentInset, y: Navbar.safeAreaOffset + contentInset / 2.0, width: contentHeight - contentInset, height: contentHeight  - contentInset))
        
        button.image = #imageLiteral(resourceName: "Ladder")
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(Navbar.ladderTapped))
        tapRecognizer.numberOfTapsRequired = 1
        button.addGestureRecognizer(tapRecognizer)
        button.isUserInteractionEnabled = true
        self.addSubview(button)
        
        let verticalWhiteLine = UIView()
        let whiteLineMargin : CGFloat = 15.0
        verticalWhiteLine.backgroundColor = UIColor.white
        verticalWhiteLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(verticalWhiteLine)
        verticalWhiteLine.widthAnchor.constraint(equalToConstant: Navbar.verticalWhiteLineWidth).isActive = true
        verticalWhiteLine.heightAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        verticalWhiteLine.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        //We create the contentInset as the offset from the left
        verticalWhiteLine.leftAnchor.constraint(equalTo: button.rightAnchor, constant: whiteLineMargin).isActive = true
        
        let pageDescriptionLabel = UILabel()
        pageDescriptionLabel.attributedText = NSAttributedString(string: string, attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 30), NSAttributedStringKey.kern : 1.0, NSAttributedStringKey.foregroundColor : UIColor.white])
        self.addSubview(pageDescriptionLabel)
        pageDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        pageDescriptionLabel.leftAnchor.constraint(equalTo: verticalWhiteLine.rightAnchor, constant: whiteLineMargin).isActive = true
        pageDescriptionLabel.centerYAnchor.constraint(equalTo: verticalWhiteLine.centerYAnchor).isActive = true
        
        switch option {
        case .displayCoins:
            let coinImage = UIImageView()
            coinImage.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(coinImage)
            coinImage.image = #imageLiteral(resourceName: "Coin")
            coinImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -contentInset).isActive = true
            coinImage.centerYAnchor.constraint(equalTo: pageDescriptionLabel.centerYAnchor).isActive = true
            
        case .displaySport:
            print("in display sports")
        }
        
    }
    
    @IBAction func ladderTapped(){
        print("the fuck?")
       // delegate.leaderboardClicked()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
