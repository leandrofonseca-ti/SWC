//
//  WebService.swift
//  SOH
//
//  Created by Leandro Fonseca on 05/06/17.
//  Copyright © 2017 Leandro. All rights reserved.
//

import Foundation
//import Parse

class WebService : BaseService {
    
    /*
    static func HorarioImovel(uiview: UIView, code: String, semana: String, completion: @escaping (_ success: Bool, _ entidade: Array<clsHorarioImovel>, _ json: String )->Void) {
        var list = Array<clsHorarioImovel>()
        
        let url = "\(UrlWebService)JsonResult/HorarioImovel/?id=\(code)&semana=\(semana)"
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            
            //asyncServiceJson(loading: true, uiview: uiview, jsonResponse: Constant.GetJsonImovel() , completion: {(success, parsedData, jsonResult)  -> () in
            
            if success {
                list = GlobalData.PopulaHorarioImovel(parsedData: parsedData)
            }
            
            completion(success, list, jsonResult)
        })
        
    }
    
    static func DiasImovel(uiview: UIView, code: String, completion: @escaping (_ success: Bool, _ entidade: clsHorarioSemana, _ json: String )->Void) {
        var item = clsHorarioSemana()
        
        let url = "\(UrlWebService)JsonResult/DiasImovel/?id=\(code)"
        asyncService(url: url, completion: {(success, parsedData, jsonResult)  -> () in
            
            //asyncServiceJson(loading: true, uiview: uiview, jsonResponse: Constant.GetJsonImovel() , completion: {(success, parsedData, jsonResult)  -> () in
            
            if success {
                item = GlobalData.PopulaDiasImovel(parsedData: parsedData)
            }
            
            completion(success, item, jsonResult)
        })
        
    }*/
    
    /*
 
    static func GetMapStyle(completion: @escaping (_ styleJson: String)->Void) {
        let urlString = URL(string: "\(UrlWebService)mapStyle/style_json4.json")
      
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("error")
                } else {
                    if let data = data {
                        if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                            //print(stringData) //JSONSerialization
                            completion(stringData)
                        }
                        
                    }
                }
            }
            task.resume()
   
        
        }
    }*/
    
    
    }


class Constant{
    
    static func GetJsonUsuario() -> String
    {
        let jsonString = "{\"Message\": \"\",\"ErrorMessage\": \"\",\"Data\": {\"Id\": 10,\"Nome\": \"Testador\",\"Sobrenome\": \"Silva\"}}"
        
        return jsonString
    }

    
    
    static func GetJsonImovel() -> String
    {
        let jsonString = "{\"Message\": \"\",\"ErrorMessage\": \"\",\"Data\": {\"Id\": 7,\"Latitude\": -30.069470,\"Longitude\": -51.216352,\"Preco\": 1500.00,\"Imagens\": [{\"Caminho\": \"http://sohimoveis.azurewebsites.net/uploads/img1.jpg\"}, {\"Caminho\": \"http://sohimoveis.azurewebsites.net/uploads/img2.jpg\"}, {\"Caminho\": \"http://sohimoveis.azurewebsites.net/uploads/img3.jpg\"}],\"Favorito\": false,\"Dormitorio\": 0,\"Vagas\": 0,\"Area\": 0.00,\"Endereco\":\"\",\"AreaFormatada\": \"0.00m\",\"PrecoFormatado\": \"R$ 1.500,00\"}}"
        
        return jsonString
    }

    
    static func GetJsonImoveis() -> String{
        
        return "{\"Success\":true,\"ErrorMessage\":\"\",\"Data\":[{\"Id\":4,\"Latitude\":-30.1139,\"Longitude\":-51.2452,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":200000,\"IMAGE\":null},{\"Id\":6,\"Latitude\":-30.1123,\"Longitude\":-51.2443,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":400000,\"IMAGE\":null},{\"Id\":26,\"Latitude\":-30.1131,\"Longitude\":-51.2428,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":210000,\"IMAGE\":null},{\"Id\":27,\"Latitude\":-30.1128,\"Longitude\":-51.2428,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":963,\"IMAGE\":null},{\"Id\":29,\"Latitude\":-30.1127,\"Longitude\":-51.2429,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":963,\"IMAGE\":null},{\"Id\":34,\"Latitude\":-22.4159,\"Longitude\":-45.466,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":963,\"IMAGE\":\"05_2017/file_20170516140409181.jpeg\"},{\"Id\":41,\"Latitude\":-30.1123,\"Longitude\":-51.2464,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":963,\"IMAGE\":null},{\"Id\":42,\"Latitude\":-30.1127,\"Longitude\":-51.2466,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":963,\"IMAGE\":null},{\"Id\":43,\"Latitude\":-30.1129,\"Longitude\":-51.2468,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":220000,\"IMAGE\":null},{\"Id\":44,\"Latitude\":-30.1131,\"Longitude\":-51.247,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":963,\"IMAGE\":null},{\"Id\":46,\"Latitude\":-30.0206,\"Longitude\":-51.1473,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":1233,\"IMAGE\":null},{\"Id\":47,\"Latitude\":-30.0192,\"Longitude\":-51.1474,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":800,\"IMAGE\":null},{\"Id\":48,\"Latitude\":-30.1141,\"Longitude\":-51.2457,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":12345679,\"IMAGE\":\"file_20160519153250922.jpg\"},{\"Id\":52,\"Latitude\":-30.1147,\"Longitude\":-51.8475,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":150000,\"IMAGE\":\"file_20160519174310119.jpg\"},{\"Id\":53,\"Latitude\":-30.1149,\"Longitude\":-51.2841,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":250000,\"IMAGE\":\"file_20160519230452591.jpg\"},{\"Id\":55,\"Latitude\":-30.1007,\"Longitude\":-51.2465,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":250000,\"IMAGE\":null},{\"Id\":56,\"Latitude\":-30.1003,\"Longitude\":-51.245,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":150000,\"IMAGE\":null},{\"Id\":57,\"Latitude\":-30.1107,\"Longitude\":-51.2475,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":450000,\"IMAGE\":\"53_2016-05-22-07-45-35.jpg\"},{\"Id\":58,\"Latitude\":-30.1153,\"Longitude\":-51.2491,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":500000,\"IMAGE\":\"02_2017/file_20170228213844545.jpeg\"},{\"Id\":59,\"Latitude\":-30.0984,\"Longitude\":-51.2373,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":200030,\"IMAGE\":\"53_2016-05-23-07-17-15.jpg\"},{\"Id\":60,\"Latitude\":-30.0977,\"Longitude\":-51.2343,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":200500,\"IMAGE\":\"53_2016-05-23-07-34-02.jpg\"},{\"Id\":61,\"Latitude\":-30.1122,\"Longitude\":-51.243,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":500000,\"IMAGE\":\"53_2016-05-23-07-57-50.jpg\"},{\"Id\":63,\"Latitude\":-30.1049,\"Longitude\":-51.2397,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":50000,\"IMAGE\":null},{\"Id\":66,\"Latitude\":-30.1058,\"Longitude\":-51.234,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":213133,\"IMAGE\":null},{\"Id\":67,\"Latitude\":-30.107,\"Longitude\":-51.2372,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":3.213123E+07,\"IMAGE\":null},{\"Id\":153,\"Latitude\":-30,\"Longitude\":-51,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":3211,\"IMAGE\":\"file_20160926225211387.jpeg\"},{\"Id\":165,\"Latitude\":-30.1054,\"Longitude\":-51.1253,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":269000,\"IMAGE\":\"02_2017/file_20170208101745054.jpeg\"},{\"Id\":166,\"Latitude\":-30.0411,\"Longitude\":-51.1961,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":279000,\"IMAGE\":\"02_2017/file_20170208101608361.jpeg\"},{\"Id\":167,\"Latitude\":-30.0111,\"Longitude\":-51.1339,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":321123,\"IMAGE\":\"02_2017/file_20170208122251228.jpeg\"},{\"Id\":171,\"Latitude\":-30.0142,\"Longitude\":-51.1342,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":10000,\"IMAGE\":null},{\"Id\":172,\"Latitude\":-30.0297,\"Longitude\":-51.2312,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":150000,\"IMAGE\":null},{\"Id\":191,\"Latitude\":-30.0521,\"Longitude\":-51.1913,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":150000,\"IMAGE\":\"04_2017/file_20170410093159382.jpeg\"},{\"Id\":196,\"Latitude\":-30.0532,\"Longitude\":-51.1923,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":2200,\"IMAGE\":\"04_2017/file_20170404104506859.jpeg\"},{\"Id\":204,\"Latitude\":-30.0521,\"Longitude\":-51.1913,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":5000000,\"IMAGE\":\"04_2017/file_20170418204237066.png\"},{\"Id\":206,\"Latitude\":0,\"Longitude\":0,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":1950000,\"IMAGE\":null},{\"Id\":207,\"Latitude\":-30.0135,\"Longitude\":-51.1478,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":290000,\"IMAGE\":\"06_2017/file_20170601111915173.jpeg\"},{\"Id\":208,\"Latitude\":-30.0141,\"Longitude\":-51.1478,\"PrecoFormatado\":\"R$ 1200\" ,\"Preco\":435345,\"IMAGE\":\"06_2017/file_20170601113459619.jpeg\"}]}"
    }
}
