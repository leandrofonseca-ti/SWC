//
//  MainController.swift
//  SWC
//
//  Created by Leandro Fonseca on 03/11/17.
//  Copyright © 2017 LF. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet var lblUser: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       if GlobalData.IsLogged().ID > 0
       {
         lblUser.text = "Hi \(GlobalData.IsLogged().NAME),"
        }
       else{
        lblUser.text = "Hello,"
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClickMenu(_ sender: Any) {
        self.revealViewController().revealToggle(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
}
