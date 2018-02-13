//
//  BaseService.swift
//  SOH
//
//  Created by Leandro Fonseca on 28/07/17.
//  Copyright © 2017 Leandro. All rights reserved.
//

import Foundation

 
class BaseService {
    
   // public static var IsProduction = false
    public static var UrlWebService = "http://leandrofonseca.pro/service/Json.ashx?method="
    public static var JsonLogin = "jsonLogin"
    //public static var JsonMapStyle = "jsonMapStyle"
    //public static var JsonNotificacoes = "jsonNotificacao"
    public static var JsonScheduleByUser = "JsonScheduleByUser"
    public static var JsonPlanTaskItems = "JsonPlanTaskItems"
    public static var JsonExtraTaskItems = "JsonExtraTaskItems"
    //public static var JsonHorarioImovel = "jsonHorarioImovel"
    //public static var JsonDiasImovel = "jsonDiasImovel"
    //public static var JsonImoveis = "jsonImoveis"
   // public static var JsonFavoritos = "jsonFavoritos"
 
    
    static func asyncService(url: String, completion: @escaping (_ success: Bool, _ data: [String:Any],_ json: String) -> ())
    {
        
        var jsonString = "{" +
                "\"ErrorMessage\": " +
                "\"1\"}" +
            "}"
      
     
        
        
        DispatchQueue.global(qos: .userInitiated).async {
           
            
            let url = URL(string: url)
            
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                guard error == nil else {
                    print(error ?? "Erro")
                   
                    
                    completion(false, [String:Any](), jsonString)
                    
                    return
                }
                guard let data = data else {
                    print("Data is empty")
                    
                    
                    completion(false, [String:Any](), jsonString)
                    return
                }
             
                jsonString = String(data: data, encoding: .utf8)!
                
                let dataJson = jsonString.data(using: .utf8)!
                
                
                if let parsedData = try? JSONSerialization.jsonObject(with: dataJson) as! [String:Any] {
                   
                    completion(true, parsedData, jsonString)
                }
                else{
                   
                    
                    completion(false, [String:Any](), jsonString)
                    
                }
                
                
            }
            
            
            
            task.resume()
            
            
            
        }
        
        
    }
    
    
    static func asyncServiceJson(jsonResponse: String, completion: @escaping (_ success: Bool, _ data: [String:Any],_ json: String) -> ())
    {
        
        var jsonString = "{" +
            "\"ErrorMessage\": " +
            "\"1\"}" +
        "}"
        
        
        DispatchQueue.global(qos: .userInitiated).async {
           
            
                jsonString = jsonResponse
            
                let dataJson = jsonString.data(using: .utf8)!
            
                if let parsedData = try? JSONSerialization.jsonObject(with: dataJson) as! [String:Any] {
                    completion(true, parsedData, jsonString)

            }
        }
    }
}
 
