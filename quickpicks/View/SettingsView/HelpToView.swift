//
//  HelpToView.swift
//  quickpicks
//
//  Created by Shreya Jain on 9/3/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation
import UIKit

class HelpToView :NavViewContainer {
        var helpController:HelpController
        var helpPassedIn : HelpController.HelpToDisplay
    let scrollview = UIScrollView()
    let textlabel = UILabel()

    init(navBarDelegate : NavBarDelegate,helpPassedInValue:HelpController.HelpToDisplay,helpC:HelpController) {
        helpController = helpC
        helpPassedIn = helpPassedInValue
        super.init(navBarDelegate : navBarDelegate)
    
        include(scrollview)
        
        print("Value pressed  \(helpPassedIn.hashValue)")
        setupHelpChoice()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupHelpChoice(){
        
        
        include(textlabel)
        placeBelow(source: textlabel, target: navbar, padding: 20.0)
        bindLeft(textlabel, target: self, 12.0)
        textlabel.font=UIFont(name:"College" , size:17)
        
          switch helpPassedIn {
          case .faq:
            textlabel.text="FAQ"
            //ScrollView
            
            bindTop(scrollview, target: navbar, 0)
            bindBottom(scrollview, target: self, 0)
            bindLeft(scrollview, target: self, 0)
            bindRight(scrollview, target: self, 0)
            
            placeBelow(source: scrollview, target: navbar, padding: 0.0)
            scrollview.translatesAutoresizingMaskIntoConstraints = false
            
            //QUESTION AND ANSWER 1
            let text_question1 = UILabel()
            include(text_question1)
            //scrollview.addSubview(text_question1)
            placeBelow(source: text_question1, target: textlabel, padding: 10.0)
            bindLeft(text_question1, target: self, 15.0)
            
            text_question1.text = "Q: What is Quick Picks?"
            let text_answer1 = UILabel()
            text_answer1.text = "A: Quick Picks is a sports pick’em app that gives real players the chance to make daily picks on their favorite teams for real rewards. Players can make picks on their favorite basketball, football, and baseball picks daily."

          //  text_answer1.adjustsFontSizeToFitWidth = true
          //  text_answer1.sizeToFit()
            text_answer1.preferredMaxLayoutWidth = UIScreen.main.bounds.width-20
            text_answer1.lineBreakMode = .byWordWrapping
            text_answer1.numberOfLines = 0

            include(text_answer1)
           // scrollview.addSubview(text_answer1)
            bindLeft(text_answer1, target: self, 15.0)
            placeBelow(source: text_answer1, target: text_question1, padding: 5.0)
            
            //QUESTION AND ANSWER 2
            let text_question2 = UILabel()
            include(text_question2)
            placeBelow(source: text_question2, target: text_answer1, padding: 10.0)
            bindLeft(text_question2, target: self, 15.0)
            text_question2.text = "Q:How much does Quick Picks cost?"
            let text_answer2 = UILabel()
            text_answer2.text = "A: Quick Picks is completely free to join and play with no in app purchases or deposits required."
            text_answer2.numberOfLines = 0
            text_answer2.lineBreakMode = .byWordWrapping
            text_answer2.adjustsFontSizeToFitWidth = true
            text_answer2.sizeToFit()
            text_answer2.preferredMaxLayoutWidth = UIScreen.main.bounds.width-20
            include(text_answer2)
            bindLeft(text_answer2, target: self, 15.0)
            placeBelow(source: text_answer2, target: text_question2, padding: 5.0)
            
            //QUESTION AND ANSWER 3
            let text_question3 = UILabel()
            include(text_question3)
            placeBelow(source: text_question3, target: text_answer2, padding: 10.0)
            bindLeft(text_question3, target: self, 15.0)
            text_question3.text = "Q: How do I win?"
            let text_answer3 = UILabel()
            text_answer3.text = "A: Players can win real prizes by entering in daily contests and placing in the top of the leaderboard. Players can also win prizes by placing in the top of the monthly and yearly leaderboard as well."
            text_answer3.numberOfLines = 0
            text_answer3.lineBreakMode = .byWordWrapping
            text_answer3.adjustsFontSizeToFitWidth = true
            text_answer3.sizeToFit()
            text_answer3.preferredMaxLayoutWidth = UIScreen.main.bounds.width-20
            include(text_answer3)
            bindLeft(text_answer3, target: self, 15.0)
            placeBelow(source: text_answer3, target: text_question3, padding: 5.0)

            
            //QUESTION AND ANSWER 4
            let text_question4 = UILabel()
            include(text_question4)
            placeBelow(source: text_question4, target: text_answer3, padding: 10.0)
            bindLeft(text_question4, target: self, 15.0)
            text_question4.text = "Q: What is the leaderboard?"
            let text_answer4 = UILabel()
            text_answer4.text = "A: The leaderboards differ between daily, monthly and yearly leaderboard. Every day there is a leaderboard made up of all the entries in the contest that rewards the top entries. The monthly and yearly leaderboard are made up of all the accumulated points you have won and reward the top players with bigger prizes."
            text_answer4.numberOfLines = 0
            text_answer4.lineBreakMode = .byWordWrapping
            text_answer4.adjustsFontSizeToFitWidth = true
            text_answer4.sizeToFit()
            text_answer4.preferredMaxLayoutWidth = UIScreen.main.bounds.width-20
            include(text_answer4)
            bindLeft(text_answer4, target: self, 15.0)
            placeBelow(source: text_answer4, target: text_question4, padding: 5.0)
            
            //QUESTION AND ANSWER 5
            let text_question5 = UILabel()
            include(text_question5)
            placeBelow(source: text_question5, target: text_answer4, padding: 10.0)
            bindLeft(text_question5, target: self, 15.0)
            text_question5.text = "Q: How can I cash out?"
            let text_answer5 = UILabel()
            text_answer5.text = "A: Players can use their tokens to redeem PayPal gift cards in the instant rewards section in the profile page."
            text_answer5.numberOfLines = 0
            text_answer5.lineBreakMode = .byWordWrapping
            text_answer5.adjustsFontSizeToFitWidth = true
            text_answer5.sizeToFit()
            text_answer5.preferredMaxLayoutWidth = UIScreen.main.bounds.width-20
            include(text_answer5)
            bindLeft(text_answer5, target: self, 15.0)
            placeBelow(source: text_answer5, target: text_question5, padding: 5.0)
            
            
          case .contactsupport:
           // textlabel.text="CONTACT SUPPORT"
            let contact_supprt = UILabel()
            include(contact_supprt)
            contact_supprt.text = "Kindly email us at "
            placeBelow(source: contact_supprt, target: textlabel, padding: 20.0)
            bindLeft(contact_supprt, target: self, 30.0)
            contact_supprt.font = Fonts.CollegeBoyWithSize(size: 25.0)
            
            let contact_email = UILabel()
            include(contact_email)
            contact_email.text = "support@quickpicksapp.com"
            let attributedString = NSMutableAttributedString(string: contact_email.text!)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.5, range: NSMakeRange(0, (contact_email.text?.count)!))
            contact_email.attributedText = attributedString
            placeBelow(source: contact_email, target: contact_supprt, padding: 20.0)
            centerHorizontally(contact_email)
            contact_email.font = Fonts.CollegeBoyWithSize(size: 30.0)
            contact_email.textColor = UIColor.red
        }
    }
    

}
