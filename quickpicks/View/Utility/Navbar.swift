//
//  Navbar.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/25/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import UIKit

class Navbar: UIView {
    static let safeAreaOffset : CGFloat = 20.0
    static let extraHeight : CGFloat = 10.0
    override init(frame: CGRect){
        let contentHeight = frame.height
        let navbarFrame = CGRect(x: 0, y: 0, width: frame.width, height: contentHeight + Navbar.safeAreaOffset + Navbar.extraHeight)
        super.init(frame: navbarFrame)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = navbarFrame
        gradientLayer.colors = [UIColor(red: 0.43137255, green: 0.74509804, blue: 0.27058824, alpha:1.0).cgColor, UIColor(red:0.55294118, green: 0.77647059, blue:0.24705882, alpha:1.0).cgColor]
        
        self.layer.addSublayer(gradientLayer)
        
        let contentInset : CGFloat = 15.0
        let button = UIImageView(frame: CGRect(x: contentInset , y: Navbar.safeAreaOffset + contentInset / 2.0, width: contentHeight - contentInset, height: contentHeight  - contentInset))
        
        button.image = #imageLiteral(resourceName: "Ladder")
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(Navbar.ladderTapped))
        tapRecognizer.numberOfTapsRequired = 1
        button.addGestureRecognizer(tapRecognizer)
        button.isUserInteractionEnabled = true
        self.addSubview(button)
        
        
    }
    
    @IBAction func ladderTapped(){
        print("ladder tapped")
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
