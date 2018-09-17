//
//  LoginEmailBase.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/19/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class LoginEmailBase : ViewContainer {
    //used in child classes
    static let TEXTFIELD_HEIGHT : CGFloat = 42
    let TEXTFIELD_PADDING : CGFloat = 15
    let TEXTFIELD_WIDTH_PERCENTAGE : CGFloat = 0.75
    let SIGNUP_BUTTON_WIDTH_PERCENTAGE : CGFloat = 0.5
    
    
    let PADDING_TOP : CGFloat = 75.0
    let IMAGES_PADDING : CGFloat = 5.0
    let IMAGES_WIDTH_PERCENTAGE : CGFloat = 0.8
    let headerImage = UIImageView(image: #imageLiteral(resourceName: "QPHeader"))
    let descriptionImage = UIImageView(image: #imageLiteral(resourceName: "QPDescription"))
    
    override init(){
        super.init()
        include(headerImage)
        include(descriptionImage)
        
        setupHeaderImage()
        setupDescriptionImage()
    }
    
    
    func setupHeaderImage(){
        centerHorizontally(headerImage)
        bindTop(headerImage, target: self, PADDING_TOP)
        bindWidth(headerImage, target: self, IMAGES_WIDTH_PERCENTAGE)
        let aspectRatio = headerImage.image!.size.height / headerImage.image!.size.width
        setHeightToWidthRatio(headerImage, aspectRatio)
        headerImage.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    func setupDescriptionImage(){
        centerHorizontally(descriptionImage)
        placeBelow(source: descriptionImage, target: headerImage, padding: IMAGES_PADDING)
        bindWidth(descriptionImage, target: self, IMAGES_WIDTH_PERCENTAGE)
        let aspectRatio = descriptionImage.image!.size.height / descriptionImage.image!.size.width
        setHeightToWidthRatio(descriptionImage, aspectRatio)
        descriptionImage.contentMode = UIViewContentMode.scaleAspectFit
    }

    override func addTo(_ controller: UIViewController) {
        super.addTo(controller)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
