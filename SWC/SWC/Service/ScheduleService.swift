//
//  ScheduleService.swift
//  SWC
//
//  Created by Leandro Fonseca on 22/11/17.
//  Copyright © 2017 LF. All rights reserved.
//

import UIKit

class ScheduleService: BaseService {

    
    static func LoadTasks(completion: @escaping (_ success: Bool, _ objs: Array<Tasks> )->Void) {
        
        //let userid = GlobalData.IsLogged().ID
        /*
         
         let url = "\(UrlWebService)JsonResult/CarregaNotificacoes/?usuarioid=\(code)"
         asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
         
         completion(success, jsonResult)
         })*/
        
        //let jsonResult = "{STATUS:true, MESSAGE:'', DATA: [{ID:1, NAME:'Schedule 1'},{ID:2, NAME:'Schedule 2'},{ID:3, NAME:'Schedule 3'}]}"
        
        
        var list: Array<Tasks> = Array()
        let item1 = Tasks()
        item1.ID = 1
        item1.NAME = "Task 1"
        item1.QUANTITY = 1
        
        let item2 = Tasks()
        item2.ID = 2
        item2.NAME = "Task 2"
        item2.QUANTITY = 1
        
        let item3 = Tasks()
        item3.ID = 3
        item3.NAME = "Task 3"
        item3.QUANTITY = 1
        
        list.append(item1)
        list.append(item2)
        list.append(item3)
        
        
        completion(true, list)
        
    }
    
    
    
    static func SaveScheduleStep1(id:Int, schedulename:String,planname:String,tasks: Array<Tasks>, completion: @escaping (_ success: Bool, _ code: Int )->Void) {
        
        var identifier: Int = 0
        var taskQty: String = ""
       for tsk in tasks
       {
        if taskQty == ""{
            taskQty = "\(tsk.ID);\(tsk.QUANTITY)"
        }
        else{
            taskQty = "\(taskQty)|\(tsk.ID);\(tsk.QUANTITY)"
        }
        }
        
        let url = "\(BaseService.UrlWebService)saveschedulestep1&id=\(id)&schedulename=\(schedulename)&planname=\(planname)&tasks=\(taskQty)"
        
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            
            
           // let jsonResult// = (prefs.value(forKey: BaseService.JsonPlanTaskItems) as? String)
           
            if(parsedData["MESSAGE"] as! String == "")
            {
                //  do {
                if let jsonItem = parsedData["DATA"] as? [String:Any]{
                        identifier = jsonItem["ID"] as! Int
                }
            }
            completion(success, identifier)
        })
        
    }
    
    
    static func LoadScheduleItem(id:Int, completion: @escaping (_ success: Bool, _ entity: ScheduleItem )->Void) {
    
        var item = ScheduleItem()
        let url = "\(BaseService.UrlWebService)getschedule&id=\(id)"
        
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            if success {
                    item = PopulaScheduleItem(parsedData: parsedData)
            }
            
            completion(success, item)
        })
        
    }
    
    
    
    static func PopulaScheduleItem(parsedData: [String: Any]) -> ScheduleItem
    {
        let entity = ScheduleItem()
        
        if(parsedData["MESSAGE"] as! String == "")
        {
            //  do {
            if let jsonItem = parsedData["DATA"] as? [String:Any]{
                entity.ID = jsonItem["ID"] as! Int
                entity.SCHEDULE_ID = jsonItem["SCHEDULE_ID"] as! Int
                entity.SCHEDULE_NAME = jsonItem["SCHEDULE_NAME"] as! String
                entity.PLAN_TASK_ID = jsonItem["PLAN_TASK_ID"] as! Int
                entity.PLAN_NAME = jsonItem["PLAN_NAME"] as! String
                entity.PERIOD_TYPE_ID = jsonItem["PERIOD_TYPE_ID"] as! Int
                entity.PERIOD_TYPE_NAME = jsonItem["PERIOD_TYPE_NAME"] as! String
                entity.TIME_BEGIN = jsonItem["TIME_BEGIN"] as! String
                entity.DATE_BEGIN = jsonItem["DATE_BEGIN"] as! String
                
                if let jsonItemDS = jsonItem["TASKS"] as? [[String:Any]] {
                    var listTasks = Array<Tasks>()
                    
                    for jsonItemSub in jsonItemDS
                    {
                        let newItemSub = Tasks()
                        newItemSub.ID = jsonItemSub["ID"] as! Int
                        newItemSub.NAME = jsonItemSub["NAME"] as! String
                        newItemSub.FULL = jsonItemSub["FULL"] as! String
                        newItemSub.EXTRA = jsonItemSub["EXTRA"] as! Bool
                        newItemSub.QUANTITY = jsonItemSub["QTY"] as! Int
                        listTasks.insert(newItemSub, at: listTasks.count)
                    }
                    
                    entity.TASKS = listTasks
                }
                
                
                
                if let jsonItemDS = jsonItem["IMAGES"] as? [[String:Any]] {
                    var listImages = Array<Picture>()
                    
                    for jsonItemSub in jsonItemDS
                    {
                        let newItemSub = Picture()
                        newItemSub.PICTURE = jsonItemSub["PICTURE"] as! String
                        listImages.insert(newItemSub, at: listImages.count)
                    }
                    
                    entity.PICTURES = listImages
                }
                
            }
        }
        return entity
    }
    
    static func SaveScheduleStep2(id:Int, description:String,time:String,date:String,images: Array<String>,completion: @escaping (_ success: Bool, _ code: Int )->Void) {
        
        var identifier: Int = 0
        var imagesPkg: String = ""
        for tsk in images
        {
            if imagesPkg == ""{
                imagesPkg = "\(tsk)"
            }
            else{
                imagesPkg = "\(imagesPkg)|\(tsk)"
            }
        }
        
        let url = "\(BaseService.UrlWebService)saveschedulestep2&id=\(id)&description=\(description)&time=\(time)&date=\(date)&images=\(imagesPkg)"
        
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            
            
            // let jsonResult// = (prefs.value(forKey: BaseService.JsonPlanTaskItems) as? String)
            
            if(parsedData["MESSAGE"] as! String == "")
            {
                //  do {
                if let jsonItem = parsedData["DATA"] as? [String:Any]{
                    identifier = jsonItem["ID"] as! Int
                }
            }
            completion(success, identifier)
        })
        
    }
    /*
    static func LoadScheduleByUser(completion: @escaping (_ success: Bool, _ objs: Array<Schedule> )->Void) {
        
        var list: Array<Schedule> = Array()
         let userid = GlobalData.IsLogged().ID
        
        let url = "\(BaseService.UrlWebService)getschedulebyuser&userid=\(userid)"
        
        
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
         
            if success {
                list = PopulaSchedules(parsedData: parsedData)
                
            }
            
            completion(success, list)
        })
        
        
        
        completion(true, list)
        
    }*/

    
     static func LoadScheduleByUser(completion: @escaping (_ success: Bool, _ json: String  )->Void) {
     
     //
     
     let url = "\(BaseService.UrlWebService)getschedulebyuser&userid=\(GlobalData.IsLogged().ID)"
     
     
     asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
    
     
     completion(success, jsonResult)
     })
     
     }
    
    
    static func LoadScheduleStaff(userid: Int, completion: @escaping (_ success: Bool, _ json: String )->Void) {
        
        let jsonResult = "{STATUS:true, MESSAGE:'', DATA: {ID:1, NAME:'Schedule 1'}}"
        completion(true, jsonResult)
    }
    
    
    static func LoadExtraTaskItems() -> Array<Tasks> {
        
        var list: Array<Tasks> = Array()
        let prefs:UserDefaults = UserDefaults.standard
        let jsonString = (prefs.value(forKey: BaseService.JsonExtraTaskItems) as? String)
        
        if jsonString != nil{
            let dataJson = jsonString?.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: dataJson!) as! [String:Any] {
                list = PopulaExtraTasks(parsedData: parsedData)
            }
        }
        
        return list
    }
    
    
    static func LoadExtraTaskItems(completion: @escaping (_ success: Bool, _ json: String  )->Void) {
        
        let url = "\(BaseService.UrlWebService)getallextratasks"
        
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            completion(success, jsonResult)
        })
        
    }
    
    
    static func LoadScheduleByUser() -> Array<Schedule> {
        
        var list: Array<Schedule> = Array()
        let prefs:UserDefaults = UserDefaults.standard
        let jsonString = (prefs.value(forKey: BaseService.JsonScheduleByUser) as? String)
        
        if jsonString != nil{
            let dataJson = jsonString?.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: dataJson!) as! [String:Any] {
                list = PopulaSchedules(parsedData: parsedData)
            }
        }
        
        return list
    }
   
    static func LoadPlanTaskItemsByPlan(plan: String) -> Array<Tasks> {
        
        var list: Array<Plan> = Array()
        let prefs:UserDefaults = UserDefaults.standard
        let jsonString = (prefs.value(forKey: BaseService.JsonPlanTaskItems) as? String)
        
        if jsonString != nil{
            let dataJson = jsonString?.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: dataJson!) as! [String:Any] {
                list = PopulaPlanTask(parsedData: parsedData)
            }
        }
        
        if list.count > 0
        {
            var listTemp: Array<Tasks> = Array()
            
            for it in list {
                if(it.NAME == plan)
                {
                   listTemp = it.TASKS
                }
            }
           return listTemp
        }
        else {
            return Array<Tasks>()
        }
    }
    
    static func LoadPlanTaskItems() -> Array<Plan> {
        
        var list: Array<Plan> = Array()
        let prefs:UserDefaults = UserDefaults.standard
        let jsonString = (prefs.value(forKey: BaseService.JsonPlanTaskItems) as? String)
        
        if jsonString != nil{
            let dataJson = jsonString?.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: dataJson!) as! [String:Any] {
                list = PopulaPlanTask(parsedData: parsedData)
            }
        }
        
        return list
    }
    
   static func LoadPlanTaskItems(completion: @escaping (_ success: Bool, _ json: String )->Void) {
        
        let url = "\(BaseService.UrlWebService)getplantask"
        
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            completion(success, jsonResult)
        })
    }
    
    
    static func PopulaExtraTasks(parsedData: [String: Any]) -> Array<Tasks>
    {
        var list = Array<Tasks>()
        
        if(parsedData["MESSAGE"] as! String == "")
        {
            //  do {
            if let jsonItems = parsedData["DATA"] as? [[String:Any]]{
                
                for jsonItem in jsonItems
                {
                    let newItem = Tasks()
                    newItem.ID = jsonItem["ID"] as! Int
                    newItem.NAME = jsonItem["NAME"] as! String
                    newItem.FULL = jsonItem["FULL"] as! String
                    newItem.EXTRA = true
                    newItem.QUANTITY = jsonItem["QTY"] as! Int
                    list.append(newItem)
                }
                
            }
        }
        return list
    }
    
    
    
    
    static func PopulaPlanTask(parsedData: [String: Any]) -> Array<Plan>
    {
        var list = Array<Plan>()
        
        if(parsedData["MESSAGE"] as! String == "")
        {
            //  do {
            if let jsonItems = parsedData["DATA"] as? [[String:Any]]{
                
                    for jsonItem in jsonItems
                    {
                        let newItem = Plan()
                        newItem.ID = jsonItem["ID"] as! Int
                        newItem.NAME = jsonItem["NAME"] as! String
                            
                        if let jsonItemDS = jsonItem["TASKS"] as? [[String:Any]] {
                            var listTasks = Array<Tasks>()
                            
                            for jsonItemSub in jsonItemDS
                            {
                                let newItemSub = Tasks()
                                newItemSub.ID = jsonItemSub["ID"] as! Int
                                newItemSub.NAME = jsonItemSub["NAME"] as! String
                                newItemSub.FULL = jsonItemSub["FULL"] as! String
                                newItemSub.EXTRA = false
                                newItemSub.QUANTITY = jsonItemSub["QTY"] as! Int
                                listTasks.insert(newItemSub, at: listTasks.count)
                            }
                            
                            newItem.TASKS = listTasks
                        }
                        list.append(newItem)
                    }
                    
                }
        }
        return list
    }
    
 
    
    static func PopulaSchedules(parsedData: [String: Any]) -> Array<Schedule>
    {
        var list = Array<Schedule>()
        
            if(parsedData["MESSAGE"] as! String == "")
            {
                //  do {
                if let jsonItems = parsedData["DATA"] as? [[String:Any]]{
                    
                    for jsonItem in jsonItems
                    {
                        let newItem = Schedule()
                        newItem.ID = jsonItem["ID"] as! Int
                        newItem.NAME = jsonItem["NAME"] as! String
                        newItem.TYPE = jsonItem["PERIOD_NAME"] as! String
                        list.append(newItem)
                    }
                    
                }
            }
            return list
        }
    
}

/*

 
*/
