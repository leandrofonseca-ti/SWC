//
//  MenuViewController.swift
//  SOH
//
//  Created by Leandro Fonseca on 11/05/17.
//  Copyright © 2017 Leandro. All rights reserved.
//

import UIKit


class MenuViewController:  UIViewController  {

    @IBOutlet var lblNomeLogado: UILabel!
    @IBOutlet var btnCriarConta: UIButton!
  
    @IBOutlet weak var containerItems: UIView!
    @IBOutlet var imgPicture: UIImageView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
     
        imgPicture.image = UIImage(named: "ic_account_circle")
        imgPicture.backgroundColor = UIColor.white

        imgPicture.layer.borderWidth = 1
        imgPicture.layer.masksToBounds = false
        imgPicture.layer.borderColor = UIColor.black.cgColor
        imgPicture.layer.cornerRadius = imgPicture.frame.height/2
        imgPicture.clipsToBounds = true
       
        ReloadMenu()
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    /*
    func ReloadFavoritos(){
        let result = GlobalData.IsLogged()
        
        if result.ID > 0
        {
            ImovelService.CarregarFavoritos(code: "\(result.ID)", completion:{(success, json) -> Void in
                if(success){
    
            OperationQueue.main.addOperation {

                    let prefs:UserDefaults = UserDefaults.standard
                    prefs.set(json, forKey: BaseService.JsonFavoritos)
    
                    }
                }
            })
        }

    }
    */
    
    
    public func ReloadMenu(){
        
        let result = GlobalData.IsLogged()
       
        if result.ID > 0
        {
            self.lblNomeLogado.text =  "\(result.NAME) \n(\(result.OCCUPATION))"
        }
      
    }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
        
}
