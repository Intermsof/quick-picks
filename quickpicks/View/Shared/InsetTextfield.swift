//
//  InsetTextfield.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 9/2/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class InsetTextfield : UITextField {
    static let textInsetAmount : CGFloat = 10.0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: InsetTextfield.textInsetAmount, dy: InsetTextfield.textInsetAmount)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: InsetTextfield.textInsetAmount, dy: InsetTextfield.textInsetAmount)
    }
}
