//
//  SplashController.swift
//  SWC
//
//  Created by Leandro Fonseca on 17/12/17.
//  Copyright © 2017 LF. All rights reserved.
//

import UIKit

class SplashController: UIViewController {
 
        var loadingView: UIView = UIView()
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        var titleLabel:UILabel?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            AddSpinner()
        
            LoadData()
        }
        
        
        
        func AddSpinner()
        {
            
            loadingView.frame = CGRect(x: 0, y:0, width: 80, height: view.frame.size.height)
            loadingView.center = self.view.center
    
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            
            activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height - 100);
            
            titleLabel = UILabel(frame: CGRect(x:0, y:0, width: 50, height: 50))
            titleLabel?.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height - 250);
            
            titleLabel!.text = "1.0"
            titleLabel!.textColor = UIColor.white
            titleLabel!.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
            titleLabel!.textAlignment = .center
            titleLabel!.translatesAutoresizingMaskIntoConstraints = false
            
            loadingView.addSubview(activityIndicator)
        
            view.addSubview(loadingView)
            activityIndicator.startAnimating()
            
        }
        
        func LoadData()
        {
            
           
                ScheduleService.LoadExtraTaskItems(completion:{(success, result) -> Void in
                    if(success){
                        OperationQueue.main.addOperation {
                            let prefs:UserDefaults = UserDefaults.standard
                            prefs.set(result, forKey: BaseService.JsonExtraTaskItems)
                        }
                    }
                })
                
                
            
                ScheduleService.LoadScheduleByUser(completion:{(success, result) -> Void in
                    if(success){
                        OperationQueue.main.addOperation {
                            let prefs:UserDefaults = UserDefaults.standard
                            prefs.set(result, forKey: BaseService.JsonScheduleByUser)
                        }
                    }
                })
             
                ScheduleService.LoadPlanTaskItems(completion:{(success, result) -> Void in
                    if(success){
                        OperationQueue.main.addOperation {
                            let prefs:UserDefaults = UserDefaults.standard
                            prefs.set(result, forKey: BaseService.JsonPlanTaskItems)
                        }
                    }
                })
                
                
            
            /*
            WebService.GetMapStyle(completion: {(result) -> Void in
                
                OperationQueue.main.addOperation {
                    let prefs:UserDefaults = UserDefaults.standard
                    prefs.set(result, forKey: BaseService.JsonMapStyle)
                }
            })
            
            ImovelService.ListarImoveis(uiview: UIView(), completion: {(json) -> Void in
                
                OperationQueue.main.addOperation {
                    
                    let prefs:UserDefaults = UserDefaults.standard
                    
                    prefs.set(json, forKey: BaseService.JsonImoveis)
                    prefs.synchronize()
                    
                    self.perform(#selector(SplashScreenController.showNavController), with: nil, afterDelay: 2)
                }
                
            })
            
            */
            //self.perform(#selector(ViewController.showNavController), with: nil, afterDelay: 2)
            
          
            self.perform(#selector(SplashController.showNavController), with: nil, afterDelay: 2)
          
        }
    
        func showNavControllerLogged(){
            performSegue(withIdentifier: "startViews", sender: self)
        }
        func showNavController(){
            performSegue(withIdentifier: "splashScreen", sender: self)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        
}

