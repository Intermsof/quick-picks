//
//  NavEnabledViewContainer.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/20/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class NavViewContainer : ViewContainer{
    let NAVBAR_HEIGHT : CGFloat = 70
    let SAFE_AREA_HEIGHT : CGFloat = 20
    let navbar : UIView = UIView()
    let navBarDelegate : NavBarDelegate
    
    init(navBarDelegate : NavBarDelegate){
        self.navBarDelegate = navBarDelegate
        super.init()
        include(navbar)
        setupNavbar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Assumes that the controller always has a navigationController
    override func addTo(_ controller: UIViewController) {
        super.addTo(controller)
        setupGradientLayer()
    }
    
    //Call in addTo function
    func setupGradientLayer(){
        self.layoutIfNeeded()
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = navbar.frame
        print("the fuck \(gradientLayer.frame.width), \(gradientLayer.frame.height), (\(gradientLayer.frame.origin.x), \(gradientLayer.frame.origin.y) )")
        print(navbar.frame.width, navbar
            .frame.height)
        gradientLayer.colors = [Colors.QPGreenLight.cgColor, Colors.QPGreenDark.cgColor]
        navbar.layer.insertSublayer(gradientLayer, at: 0)
            //.layer.addSublayer(gradientLayer)
    }
    
    func getLeftButtonWrapper(){
        
    }
    
    @objc func leftButtonTapped(){
        self.navBarDelegate.leftButtonTapped()
    }
    
    func setupNavbar(){
        bindTop(navbar, target: self, 0)
        bindWidth(navbar, target: self, 1.0)
        navbar.heightAnchor.constraint(equalToConstant: NAVBAR_HEIGHT).isActive = true
        
        let buttonHeight = NAVBAR_HEIGHT - SAFE_AREA_HEIGHT
        let leftPadding : CGFloat = 10
        let imageHeight : CGFloat = 30
        let topPadding : CGFloat = (buttonHeight - imageHeight) / 2.0
        
        //A wrapper for the left button that is larger than its child image view. This allows for easier clicking
        let leftButtonWrapper = UIView(frame: CGRect(x: 0, y: SAFE_AREA_HEIGHT, width: buttonHeight, height: buttonHeight))
        let leftButtonImage = UIImageView(frame: CGRect(x: leftPadding, y: topPadding, width: imageHeight,height: imageHeight))
        leftButtonImage.image = navBarDelegate.getLeftButtonImage()
        leftButtonWrapper.addSubview(leftButtonImage)
        
        /*------------Set up tap recognizer to add to leftButtonWrapper-------------*/
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NavViewContainer.leftButtonTapped))
        tapRecognizer.numberOfTapsRequired = 1
        leftButtonWrapper.addGestureRecognizer(tapRecognizer)
        leftButtonWrapper.isUserInteractionEnabled = true
        navbar.addSubview(leftButtonWrapper)
        
        /*---- Set up pargeDescriptionLabel and position it using constraints ------*/
        let pageDescriptionLabel = UILabel()
        pageDescriptionLabel.attributedText = NSAttributedString(string: navBarDelegate.getNavbarTitle(), attributes: [NSAttributedStringKey.font : Fonts.CollegeBoyWithSize(size: 25), NSAttributedStringKey.kern : 1.0, NSAttributedStringKey.foregroundColor : UIColor.white])
        navbar.addSubview(pageDescriptionLabel)
        pageDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        pageDescriptionLabel.leftAnchor.constraint(equalTo: leftButtonWrapper.rightAnchor, constant: 10).isActive = true
        pageDescriptionLabel.centerYAnchor.constraint(equalTo: leftButtonWrapper.centerYAnchor).isActive = true
        
        
        
        //leftButtonWrapper.image = #imageLiteral(resourceName: "Ladder")
        
        
    //    button.image = #imageLiteral(resourceName: "Ladder")
        /*
        
        
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
