//
//  NavEnabledViewContainer.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/20/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class NavViewContainer : ViewContainer {
    let NAVBAR_HEIGHT : CGFloat = 60
    let SAFE_AREA_HEIGHT : CGFloat = 20
    let navBar : UIView = UIView()
    
    override init(){
        super.init()
        include(navBar)
        setupNavbar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Assumes that the controller always has a navigationController
    override func addTo(_ controller: UIViewController) {
        super.addTo(controller)
        
    }
    
    //Not used for now
    func finishSetupNavbar(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = navBar.frame
        gradientLayer.colors = [Colors.QPGreenDark.cgColor, Colors.QPGreenLight.cgColor]
        navBar.layer.addSublayer(gradientLayer)
    }
    
    func setupNavbar(){
        bindTop(navBar, target: self, 0)
        bindWidth(navBar, target: self, 1.0)
        navBar.heightAnchor.constraint(equalToConstant: NAVBAR_HEIGHT).isActive = true
        
        navBar.backgroundColor = Colors.QPGreenLight
        
        let buttonHeight = NAVBAR_HEIGHT - SAFE_AREA_HEIGHT
        //A wrapper for the left button that is larger than its child image view. This allows for easier clicking
        let leftButtonWrapper = UIView(frame: CGRect(x: 0, y: SAFE_AREA_HEIGHT, width: buttonHeight, height: buttonHeight))
        leftButtonWrapper.backgroundColor = UIColor.red
    
        print("finished setting up")
    //    button.image = #imageLiteral(resourceName: "Ladder")
        /*
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
 
 */
    }
}
