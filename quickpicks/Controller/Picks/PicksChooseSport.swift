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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //Default navbar does not meet our needs. So create a custom navbar
        let customNavbar = Navbar(frame: (self.navigationController?.navigationBar.frame)!)
        //CGRect(x: 0, y: 0, width: self.view.frame.width, height: ()! + 20))
        
        self.view.addSubview(customNavbar)
        
      //  self.navigationController?.navigationBar.layer.addSublayer(gradientLayer)
        
        
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
