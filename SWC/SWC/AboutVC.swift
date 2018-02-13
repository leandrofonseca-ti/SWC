//
//  HelpVC.swift
//  SWC
//
//  Created by Leandro Fonseca on 21/01/18.
//  Copyright © 2018 LF. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    @IBAction func clickMenu(_ sender: Any) {
        
        self.revealViewController().revealToggle(animated: true)
        
    }
}
