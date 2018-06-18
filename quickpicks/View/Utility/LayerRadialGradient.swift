//
//  LayerRadialGradient.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/13/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

/*
 -------------------------- DESCRIPTION OF CLASS FUNCTIONALITY ---------------------------------
 
 A CALayer subclass that draws a radial gradient in the quick picks green colors defined in the
 colors file. The lighter green color is in the center, and the darker green in the outer radius.
 
 -------------------------- DOCUMENTATION UPDATED 06/13/18 -------------------------------------
 */

import UIKit

class LayerRadialGradient: CALayer {
    required override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(layer: Any) {
        super.init(layer: layer)
    }
    
    public var colors = [Colors.QPGreenDark.cgColor, Colors.QPGreenLight.cgColor]
    
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var locations = [CGFloat]()
        for i in 0...colors.count-1 {
            locations.append(CGFloat(i) / CGFloat(colors.count))
        }
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
        let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        let radius = max(bounds.width, bounds.height)
        ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
    }
}
