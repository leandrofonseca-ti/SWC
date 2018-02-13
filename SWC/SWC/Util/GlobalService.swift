//
//  GlobalService.swift
//  SOH
//
//  Created by Leandro Fonseca on 05/0IsLogged6/17.
//  Copyright © 2017 Leandro. All rights reserved.
//

import Foundation


class GlobalService{

    /*
    static func IsLogged() -> Bool
    {
        let prefs:UserDefaults = UserDefaults.standard
        let perfilid = prefs.value(forKey: "perfilid") as? Int
        if perfilid != nil && perfilid != 0
        {
            return true
        }
        return false
    }
    */
    
    static func GetMapStyle() -> String
    {
        let prefs:UserDefaults = UserDefaults.standard
        
        let jsonString = (prefs.value(forKey: "jsonMapStyle") as? String)
        
        if(jsonString == nil){
            return ""
        }else
        {
        return jsonString!
        }
    }
    /*
    static func ListImoveis() -> Array<JsonImovel>
    {
        let prefs:UserDefaults = UserDefaults.standard
        
        let array = (prefs.value(forKey: BaseService.JsonImoveis) as? Array<Imovel>)
        
        return array!
    }
    */
    /*static func ListImoveis() -> Array<clsProduct>
    {
        var list = Array<clsProduct>()
        
        //if IsLogged()
        //{
            let prefs:UserDefaults = UserDefaults.standard
        
            let jsonString = (prefs.value(forKey: GlobalData.JsonImoveis) as? String)
            
            let data = jsonString?.data(using: .utf8)!
            
            if let parseJSON = try? JSONSerialization.jsonObject(with: data!) as! [String:Any] {
                
               
                    
                     if ((parseJSON["ErrorMessage"] as? String) == "") {
                        if let jsonItems = parseJSON["Data"] as? [[String:Any]] {
                            for jsonItem in jsonItems
                            {
                                let newItem = clsProduct()
                                newItem.ID = jsonItem["Id"] as! Int
                                newItem.LAT =  jsonItem["Latitude"] as! Float
                                newItem.LON =  jsonItem["Longitude"] as! Float
                                newItem.PRICE =  jsonItem["Preco"] as! Float
                                newItem.PRICEFMT = jsonItem["PrecoFormatado"] as! String
                               
                                //if let y = jsonItem["IMAGE"] as? String {
                                    //newItem.IMAGE =  y //jsonItem["IMAGE"] as! String
                               // }
                                list.insert(newItem, at: list.count)
                            }
                        }
                    }
               
                
            //}
        }
        return list
        
    }*/
    
    static func GetLogin(nome: String, senha: String) -> User
    {
        let entidade = User()
        let prefs:UserDefaults = UserDefaults.standard
        let jsonObj = prefs.value(forKey: BaseService.JsonLogin) as? Int
        
        if jsonObj != nil
        {
            /*
            entidade.Sucesso = true
            entidade.PerfilId = perfilid!
            
            entidade.Nome = (prefs.value(forKey: "nome") as? String)!
            entidade.UserName = (prefs.value(forKey: "username") as? String)!
            entidade.Email = (prefs.value(forKey: "email") as? String)!
            */
            //  entidade.EmpresaId = (prefs.value(forKey: "empresaid") as? Int)!
            /*
             let jsonProjeto = (prefs.value(forKey: "jsonProjeto") as? String)
             if jsonProjeto != nil {
             entidade.ListaProjeto = ConvertJsonToSelectItem(json: jsonProjeto!)
             }
             
             let jsonCategoria = (prefs.value(forKey: "jsonCategoria") as? String)
             if jsonCategoria != nil {
             entidade.ListaCategoria = ConvertJsonToSelectItem(json: jsonCategoria!)
             }
             
             let jsonMenu = (prefs.value(forKey: "jsonMenu") as? String)
             if jsonMenu != nil {
             entidade.Menus = ConvertJsonToSelectItemMenu(json: jsonMenu!)
             }*/
        }
        else
        {
           // entidade.Sucesso = false
        }
        
        return entidade
    }
    
    /*
    
    
    static func GetUsuario() -> Usuario
    {
        let entidade = Usuario()
        let prefs:UserDefaults = UserDefaults.standard
        let perfilid = prefs.value(forKey: "perfilid") as? Int
        
        if perfilid != nil && perfilid != 0
        {
            entidade.Sucesso = true
            entidade.PerfilId = perfilid!
            
            entidade.Nome = (prefs.value(forKey: "nome") as? String)!
            entidade.UserName = (prefs.value(forKey: "username") as? String)!
            entidade.Email = (prefs.value(forKey: "email") as? String)!
            //  entidade.EmpresaId = (prefs.value(forKey: "empresaid") as? Int)!
            /*
             let jsonProjeto = (prefs.value(forKey: "jsonProjeto") as? String)
             if jsonProjeto != nil {
             entidade.ListaProjeto = ConvertJsonToSelectItem(json: jsonProjeto!)
             }
             
             let jsonCategoria = (prefs.value(forKey: "jsonCategoria") as? String)
             if jsonCategoria != nil {
             entidade.ListaCategoria = ConvertJsonToSelectItem(json: jsonCategoria!)
             }
             
             let jsonMenu = (prefs.value(forKey: "jsonMenu") as? String)
             if jsonMenu != nil {
             entidade.Menus = ConvertJsonToSelectItemMenu(json: jsonMenu!)
             }*/
        }
        else
        {
            entidade.Sucesso = false
        }
        
        return entidade
    }
    
    static func ConvertJsonToSelectItemMenu(json: String)-> Array<SelectItemMenu>
    {
        var list = Array<SelectItemMenu>()
        let dataJson = json.data(using: .utf8)!
        
        if let parsedData = try? JSONSerialization.jsonObject(with: dataJson) as! [[String:Any]] {
            
            do {
                for jsonItem in parsedData
                {
                    let newItem = SelectItemMenu()
                    
                    for (key, value) in jsonItem {
                        //print("key \(key) value2 \(value)")
                        
                        switch key
                        {
                        case"IconId":
                            newItem.IconId = value as! Int
                        case "Name":
                            newItem.Name = value as! String
                        case "Id":
                            newItem.Id = value as! Int
                        default:
                            print("Nenhum")
                        }
                    }
                    list.insert(newItem, at: list.count)
                    
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
        }
        
        return list
    }
    
    
    static func ConvertJsonToSelectItem(json: String)-> Array<SelectItem>
    {
        var list = Array<SelectItem>()
        let dataJson = json.data(using: .utf8)!
        if let parsedData = try? JSONSerialization.jsonObject(with: dataJson) as! [String:Any] {
            
            if(parsedData["Sucesso"] as! Bool)
            {
                do {
                    if let jsonItems = parsedData["Data"] as? [[String:Any]] {
                        for jsonItem in jsonItems
                        {
                            let newItem = SelectItem()
                            newItem.Text = jsonItem["Value"] as! String
                            newItem.Value =  jsonItem["Key"] as! String
                            list.insert(newItem, at: list.count)
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                
            }
        }
        return list
    }
    
    */
    
}
