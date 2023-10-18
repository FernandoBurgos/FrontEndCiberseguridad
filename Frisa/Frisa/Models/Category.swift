//
//  Category.swift
//  Frisa
//
//  Created by Alumno on 17/10/23.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Cat: Hashable{
    var name: String
    var id: String
    
    init() {
        self.name = ""
        self.id = ""
    }
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
}

func getCategories() async throws -> [Cat] {
    let url = apiURL + "/api/v1/getAllCategories"
    let session = Session(interceptor:  AccessTokenAdapter());
    var Categories: [Cat] = []
        
    return try await withCheckedThrowingContinuation { continuation in
        session.request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON {response in
                if let error = response.error {
                    print("Error de conexión")
                    continuation.resume(throwing: error)
                } else {
                    let json = try! JSON(data: response.data!)
                    
                    let allCategories = json["categories"].arrayValue
                    
                    for cat in allCategories{
                        let newCategory = Cat(name: cat["name"].stringValue,
                                                   id: cat["_id"].stringValue)
                        Categories.append(newCategory)
                        
                    }
                    
                    continuation.resume(returning: Categories)
                }
            }
    }
}
