//
//  PicksChooseSportViewController.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 6/20/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import UIKit

class PicksChooseSport: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RealtimeModel.shared.printMe()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = (self.navigationController?.navigationBar.bounds)!
        
        gradientLayer.colors = [UIColor(red: 0.43137255, green: 0.74509804, blue: 0.27058824, alpha:1.0).cgColor, UIColor(red:0.55294118, green: 0.77647059, blue:0.24705882, alpha:1.0).cgColor]
        
        self.navigationController?.navigationBar.layer.addSublayer(gradientLayer)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
