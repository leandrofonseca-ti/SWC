//
//  Helper.swift
//  Imoveis
//
//  Created by Leandro Fonseca on 05/09/17.
//  Copyright © 2017 SOHImoveis. All rights reserved.
//


import SystemConfiguration


class Helper
{
    func CheckConnection(callback: ()?)
    {
        
    }
    
    func CheckConnection() -> Bool
    {
        var result: Bool = false
        if(connectedToNetwork()){
            /*OperationQueue.main.addOperation {
             }*/
            result = true
            
        }
        else
        {
            let alert = UIAlertController(title: "Alerta", message: "Sem acesso à internet", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                   result = self.CheckConnection()
            }
            alert.addAction(okAction)
            
            // show alert
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
        
        return result
    }
    /*
    func CheckGPS() -> Bool
    {
        var result: Bool = false
        if(gpsEnabled()){
            /*OperationQueue.main.addOperation {
             }*/
            result = true
            
        }
        else
        {
            let alert = UIAlertController(title: "Alerta", message: "Serviço de localização inativo", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                result = self.CheckGPS()
            }
            alert.addAction(okAction)
            
            // show alert
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
        
        return result
    
    
    }*/
   /* func CheckConnectionCallBack(callback: ()?)
    {
       
        if(Helper().connectedToNetwork()){
            /*OperationQueue.main.addOperation {
             }*/
           callback
            
        }
        else
        {
            let alert = UIAlertController(title: "Alerta", message: "Sem acesso à internet", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                if Helper().connectedToNetwork() {
                    self.CheckConnectionCallBack(callback: callback)
                }
            }
            alert.addAction(okAction)
            
            // show alert
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    */
    
   private func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    /*
    private func gpsEnabled() -> Bool {
        
        var result: Bool = false
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus())
            {
            case .notDetermined, .restricted, .denied:
                result = false //print("No access")
            
            case .authorizedAlways, .authorizedWhenInUse:
                result = true //print("Access")
            }
        }
        else
        {
            print("Location services are not enabled")
        }
        
        return result
    }*/

}
