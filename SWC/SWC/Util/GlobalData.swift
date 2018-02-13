//
//  GlobalData.swift
//  SOH
//
//  Created by Leandro Fonseca on 20/07/17.
//  Copyright © 2017 Leandro. All rights reserved.
//

import Foundation


class GlobalData{
       //public static var UrlWebService = "http://" // com barra no final

    static func IsLogged() -> User
    {
        
        var item = User()

        let prefs:UserDefaults = UserDefaults.standard
        
        
        let jsonString = (prefs.value(forKey: BaseService.JsonLogin) as? String)
        
        if jsonString != nil{
            let dataJson = jsonString?.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: dataJson!) as! [String:Any] {
                item = UserService.PopulaUser(parsedData: parsedData)
            }
        }
        
        /*
        item.ID = 1;
        item.NAME = "Alice Hunnty"
        item.OCCUPATION = "Customer"
        item.PROFILEID = */
        return item;
       
    }
    
    
    static func Logout(){
        let prefs:UserDefaults = UserDefaults.standard
        
        prefs.set(nil, forKey:BaseService.JsonLogin)
        
    }
    
   /* static func GetDiasImovel() -> clsHorarioSemana
    {
        
        var item = clsHorarioSemana()
        
        let prefs:UserDefaults = UserDefaults.standard
        
        
        let jsonString = (prefs.value(forKey: BaseService.JsonDiasImovel) as? String)
        
        if jsonString != nil{
            let dataJson = jsonString?.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: dataJson!) as! [String:Any] {
                item = PopulaDiasImovel(parsedData: parsedData)
            }
        }
        
        return item
    }*/

    
    /*
    static func GetItemHorario() -> Array<clsHorarioImovel>
    {
        
        var item = Array<clsHorarioImovel>()
        
        let prefs:UserDefaults = UserDefaults.standard
        
        
        let jsonString = (prefs.value(forKey: BaseService.JsonHorarioImovel) as? String)
        
        if jsonString != nil{
            let dataJson = jsonString?.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: dataJson!) as! [String:Any] {
                item = PopulaHorarioImovel(parsedData: parsedData)
            }
        }
        
        return item
    }
    
 
   

    static func PopulaHorarioImovel(parsedData: [String:Any]) -> Array<clsHorarioImovel>
    {
        var list = Array<clsHorarioImovel>()
        
        if(parsedData["ErrorMessage"] as! String == "")
        {
                 if let jsonItems = parsedData["Data"] as? [[String:Any]] {
                    
                    
                        for jsonItem in jsonItems
                        {
                            let newItem = clsHorarioImovel()
                            newItem.Id = jsonItem["Id"] as! Int
                            newItem.HoraMinuto = jsonItem["HoraMinuto"] as! String
                            newItem.Semana = jsonItem["Semana"] as! Int
                            list.insert(newItem, at: list.count)
                        }
                    }
            
        }
        return list
    }
    
    static func PopulaDiasImovel(parsedData: [String:Any]) -> clsHorarioSemana
    {
        let item = clsHorarioSemana()
        
        if(parsedData["ErrorMessage"] as! String == "")
        {
                if let jsonItems = parsedData["Data"] as? [String:Any] {
                   
                    
                    if let jsonItemDS = jsonItems["DiasSemana"] as? [[String:Any]] {
                        var list = Array<clsDiasSemana>()
                        
                        for jsonItemSemana in jsonItemDS
                        {
                            let newItem = clsDiasSemana()
                            newItem.TemHorario = jsonItemSemana["TemHorario"] as! Bool
                            newItem.Semana = jsonItemSemana["Semana"] as! Int
                            newItem.SemanaNome = jsonItemSemana["SemanaNome"] as! String
                            
                            
                            list.insert(newItem, at: list.count)
                        }
                        
                        item.Semanas = list
                    }
                    
                    
                    if let jsonItemDS = jsonItems["DatasSemana"] as? [[String:Any]] {
                        var list = Array<clsDatasSemana>()
                        
                        for jsonItemSemana in jsonItemDS
                        {
                            let newItem = clsDatasSemana()
                            newItem.Semana = jsonItemSemana["Semana"] as! Int
                            newItem.Dia = jsonItemSemana["Dia"] as! Int
                            newItem.Mes = jsonItemSemana["Mes"] as! Int
                            newItem.Ano = jsonItemSemana["Ano"] as! Int
                            newItem.TemHorario = jsonItemSemana["TemHorario"] as! Bool
                            list.insert(newItem, at: list.count)
                        }
                        
                        item.Datas = list
                    }
                }
                  }
        return item
    }
    */

}
