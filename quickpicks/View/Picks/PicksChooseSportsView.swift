//
//  PicksChooseSportsView.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/20/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class PicksChooseSportView : NavViewContainer {
    let picksChooseSportViewDelegate : PicksChooseSportViewDelegate
    let SPORT_BUTTON_PADDING : CGFloat = 10.0
    var sportsButtonAdded : [UIImageView] = []
    
    init(navBarDelegate : NavBarDelegate, picksChooseSportViewDelegate : PicksChooseSportViewDelegate){
        self.picksChooseSportViewDelegate = picksChooseSportViewDelegate
        super.init(navBarDelegate : navBarDelegate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sportButtonTapped(_ sender: ChooseSportRecognizer){
        print("hello")
        picksChooseSportViewDelegate.sportButtonTapped(sport: sender.sport)
    }
    
    func clearSportsButtons(){
        for button in sportsButtonAdded {
            button.removeFromSuperview()
        }
    }
    
    func drawSports(_ sports: [Sport]){
        clearSportsButtons()
        print("drawing sports")
        var lastView : UIImageView? = nil
        for sport in sports {
            let imageView = UIImageView(image: UIImage(imageLiteralResourceName: "\(sport.id)Black"))
            let recognizer = ChooseSportRecognizer(target: self, action: #selector(self.sportButtonTapped(_:)))
            recognizer.sport = sport
            recognizer.isEnabled = true
            recognizer.numberOfTapsRequired = 1
            imageView.addGestureRecognizer(recognizer)
            imageView.isUserInteractionEnabled = true
            
            include(imageView)
            bindWidth(imageView, target: self, 1.0)
            setHeightToWidthRatio(imageView, imageView.image!.size.height / imageView.image!.size.width)
            
            if let _lastView = lastView {
                placeBelow(source: imageView, target: _lastView, padding: SPORT_BUTTON_PADDING)
                lastView = imageView
            }
            else {
                placeBelow(source: imageView, target: navbar, padding: SPORT_BUTTON_PADDING)
                lastView = imageView
            }
            
            sportsButtonAdded.append(imageView)
        }
    }
}
