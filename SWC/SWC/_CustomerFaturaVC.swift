//
//  CustomerFaturaVC.swift
//  SWC
//
//  Created by Leandro Fonseca on 21/11/17.
//  Copyright © 2017 LF. All rights reserved.
//

import UIKit

class CustomerFaturaVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        // Do any additional setup after loading the view.
    }
    @IBAction func clickMenu(_ sender: Any) {
        self.revealViewController().revealToggle(animated: true)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
