//
//  LayerEffects.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/13/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import UIKit

class LayerEffects {
    static func AddShadowToView(_ view : UIView, withRadius: CGFloat, color: UIColor, opacity : Float, offset : CGSize){
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = withRadius
    }
    
    static func AddRoundedBorderToView(_ view: UIView, withRadius : CGFloat){
        view.layer.cornerRadius = withRadius
    }
}
