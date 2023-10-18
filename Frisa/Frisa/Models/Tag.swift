//
//  Tag.swift
//  Frisa
//
//  Created by Alumno on 25/09/23.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Tag:Identifiable {
    var name: String
    var id = UUID()
}

struct tagResponse{
    var status: String
    var tag: [String]
    
    init() {
        self.status = "Error"
        self.tag = []
    }
}

func createTag(tag: Tag) async throws -> String? {
    let url = apiURL + "/api/v1/createTag"
    let session = Session(interceptor:  AccessTokenAdapter());
    
    return try await withCheckedThrowingContinuation { continuation in
        let tagDict: [String: Any] = [
            "name": tag.name
        ]
        
        session.request(url, method: .post, parameters: tagDict, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    if let jsonData = try? JSONSerialization.data(withJSONObject: data),
                       let json = try? JSONDecoder().decode([String: String].self, from: jsonData),
                       let id = json["tagId"] {
                        continuation.resume(returning: id) // Return the 'id' on success.
                    } else {
                        continuation.resume(returning: nil) // Return nil if 'id' couldn't be extracted.
                    }
                case .failure(let error):
                    print(error)
                    continuation.resume(throwing: error) // Throw an error on failure.
                }
            }
    }
}

//func getTag(id: String) async throws -> tagResponse {
//    let url = apiURL + "/api/v1/getTag/\(id)"
//    let session = Session(interceptor:  AccessTokenAdapter());
//    return try await withCheckedThrowingContinuation { continuation in
//            session.request(url, method: .get)
//                .responseJSON { response in
//                    switch response.result {
//                    case .success(let data):
//                        print(data)
//                        // Process the response data here if needed.
//                        continuation.resume(returning: data as! tagResponse) // Return true on success.
//                    case .failure(let error):
//                        print(error)
//                        continuation.resume(throwing: error) // Throw an error on failure.
//                    }
//                }
//        }
//}

func getArrTags(ids: [String]) async throws -> [String] {
    let url = apiURL + "/api/v1/getTagsNames"
    let session = Session(interceptor:  AccessTokenAdapter());
    var tagNames: [String] = []
    
    return try await withCheckedThrowingContinuation { continuation in
        let tagDict: [String: Any] = [
            "tags": ids
        ]
        
        session.request(url, method: .post, parameters: tagDict, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let error = response.error {
                    print("Error de conexión")
                    continuation.resume(throwing: error)
                } else {
                    let json = try! JSON(data: response.data!)
                    
                    let tagnames = json["tags"].arrayValue
                    
                    for tag in tagnames{
                        let newtag = tag.stringValue
                        tagNames.append(newtag)
                        
                    }
                    continuation.resume(returning: tagNames)
                }
                
            }
    }
}
