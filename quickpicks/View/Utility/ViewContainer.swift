//
//  ViewContainer.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/18/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class ViewContainer : UIView {
    init(){
        super.init(frame: CGRect())
        //We will always be taking care of contraints manually!!!!
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addTo(_ controller : UIViewController){
        controller.view.addSubview(self)
        self.widthAnchor.constraint(equalTo: controller.view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: controller.view.heightAnchor).isActive = true
    }
    
    func bindLeft(_ source: UIView, target: UIView, _ padding: CGFloat){
        source.leftAnchor.constraint(equalTo: target.leftAnchor, constant: padding).isActive = true
    }
    
    func bindRight(_ source: UIView, target: UIView, _ padding: CGFloat){
        source.rightAnchor.constraint(equalTo: target.rightAnchor, constant: -padding).isActive = true
    }
    
    func bindTop(_ source: UIView, target: UIView, _ padding: CGFloat){
        source.topAnchor.constraint(equalTo: target.topAnchor, constant: padding).isActive = true
    }
    
    func bindBottom(_ source: UIView, target: UIView, _ padding: CGFloat){
        source.bottomAnchor.constraint(equalTo: target.bottomAnchor, constant: -padding).isActive = true
    }
    
    func bindWidth(_ source : UIView, target: UIView, _ percentage : CGFloat){
        source.widthAnchor.constraint(equalTo: target.widthAnchor, multiplier: percentage).isActive = true
    }
    
    func bindHeight(_ source : UIView, target: UIView, _ percentage : CGFloat){
        source.heightAnchor.constraint(equalTo: target.heightAnchor, multiplier: percentage).isActive = true
    }
    
    func setHeightToWidthRatio(_ source : UIView, _ ratio : CGFloat){
        source.heightAnchor.constraint(equalTo: source.widthAnchor, multiplier: ratio).isActive = true
    }
    
    func setWidthToHeightRatio(_ source : UIView, _ ratio : CGFloat){
        source.widthAnchor.constraint(equalTo: source.heightAnchor, multiplier: ratio).isActive = true
    }
    
    func centerHorizontally(_ source : UIView){
        source.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func centerVertically(_ source : UIView){
        source.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func placeBelow(source: UIView, target: UIView, padding: CGFloat){
        source.topAnchor.constraint(equalTo: target.bottomAnchor, constant: padding).isActive = true
    }
    
    func placeAbove(source: UIView, target: UIView, padding: CGFloat){
        source.bottomAnchor.constraint(equalTo: target.topAnchor, constant: -padding).isActive = true
    }
    
    func placeLeft(source: UIView, target: UIView, padding: CGFloat){
        source.rightAnchor.constraint(equalTo: target.leftAnchor, constant: -padding).isActive = true
    }
    
    func placeRight(source: UIView, target: UIView, padding: CGFloat){
        source.leftAnchor.constraint(equalTo: target.rightAnchor, constant: padding).isActive = true
    }
    
    func include(_ view : UIView){
        //We will always be taking care of constraints manually!!!!
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
    static func setupRadialGradient(_ view : UIView){
        let radialGradient = LayerRadialGradient()
        radialGradient.frame = view.frame
        view.layer.insertSublayer(radialGradient, at: 0)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
