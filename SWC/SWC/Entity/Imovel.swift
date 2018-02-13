//
//  Imovel.swift
//  Imoveis
//
//  Created by Leandro Fonseca on 07/09/17.
//  Copyright © 2017 SOHImoveis. All rights reserved.
//

import Foundation


struct JsonImovel : Unmarshaling {
    var ID : Int = 0
    //let UsuarioId : Int = 0
    let Codigo : String = ""
    var Latitude : Float = 0
    var Longitude : Float = 0
    var PrecoDec : Float = 0
    var PrecoTexto : String = ""
    var Endereco : String = ""
    var Vagas : Int = 0
    var Dormitorio : Int = 0
    var Area : Float = 0
    var AreaFormatada : String = ""
    let Descricao : String = ""
    var Favorito : Bool = false
    var Imagens : Array<UIImage> = []
    
    public init()
    {
        
    }
    public init(object json:MarshaledObject) throws {
        ID = try! json.value(for: "Id")
        Latitude = try! json.value(for: "Latitude") ?? 0
        Longitude = try json.value(for: "Longitude") ?? 0
        PrecoDec = try json.value(for: "Preco") ?? 0
        Endereco = try json.value(for: "Endereco") ?? ""
        PrecoTexto = try json.value(for: "PrecoFormatado") ?? ""
        Favorito = try json.value(for: "Favorito") ?? false
        Dormitorio = try json.value(for: "Dormitorio") ?? 0
        Vagas = try json.value(for: "Vagas") ?? 0
        Area = try json.value(for: "Area") ?? 0
        AreaFormatada = try json.value(for: "AreaFormatada") ?? ""
        
        
        var imgs = [String]()
        imgs = try json.value(for: "Imagens.Caminho") ?? []
        
        var list = Array<UIImage>()
        
        for caminho in imgs
        {
            let strUrl = URL(string:  "\(BaseService.UrlWebService)uploads/\(caminho)")
            let data = try? Data(contentsOf: strUrl!)
            let newItem: UIImage = UIImage(data:data!)!
            list.insert(newItem, at: list.count)
        }
        Imagens = list
    }
    
}

