import Foundation

class UserService : BaseService {
    
   /*
    static func SalvarUsuario(nome: String, sobrenome: String, email: String, celular: String, senha: String, completion: @escaping (_ success: Bool, _ json: String )->Void) {
        
        let url = "\(UrlWebService)JsonResult/SalvarUsuario/?nome=\(nome)&email=\(email)&celular=\(celular)&senha=\(senha)"
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            
            completion(success, jsonResult)
        })
    }
 */
    
    
    static func ForgotPassword(uiview: UIView, phone: String, completion: @escaping (_ success: Bool, _ entidade: User, _ json: String )->Void) {
        var entidade = User()
        
        let url = "\(BaseService.UrlWebService)forgot&phone=\(phone)"
        
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            
            if success {
                entidade = PopulaUser(parsedData: parsedData)
                
            }
            
            completion(success, entidade, jsonResult)
        })
        
    }

    
    
    static func CreateAccount(_ name: String, _ lastname: String , _ email: String, _ phone: String, _ password: String ,  completion: @escaping (_ success: Bool, _ message: String )->Void) {
        
        let url = "\(BaseService.UrlWebService)savecustomer&name=\(name)&lastname=\(lastname)&email=\(email)&phone=\(phone)&password=\(password)"
        
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            let msg = parsedData["MESSAGE"] as! String
            completion(success, msg)
        })
        
    }

  
    static func GetLogin(uiview: UIView, phone: String, senha: String, completion: @escaping (_ success: Bool, _ entidade: User, _ json: String )->Void) {
        var entidade = User()
        
        let url = "\(BaseService.UrlWebService)login&phone=\(phone)&password=\(senha)"
        
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            
            if success {
                entidade = PopulaUser(parsedData: parsedData)
        
            }
            
            completion(success, entidade, jsonResult)
        })
        
    }
    
    static func PopulaUser(parsedData: [String: Any]) -> User
    {
        let item = User()
        
        if(parsedData["MESSAGE"] as! String == "")
        {
            //  do {
            if let jsonItem = parsedData["DATA"] as? [String:Any] {
                
                item.ID = jsonItem["ID"] as! Int
                
                if(item.ID > 0){
                    item.NAME =  jsonItem["NAME"] as! String
                    item.PHONE =  jsonItem["PHONE"] as! String
                    item.LASTNAME = jsonItem["LASTNAME"] as! String
                    item.OCCUPATION = jsonItem["OCCUPATION"] as! String
                    item.PROFILEID = jsonItem["PROFILEID"] as! Int
                }
                
            }
            
            
        }
        return item
    }
    
}
