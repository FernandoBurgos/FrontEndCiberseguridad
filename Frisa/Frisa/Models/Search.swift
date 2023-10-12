//
//  Search.swift
//  Frisa
//
//  Created by Alumno on 12/10/23.
//

import Foundation
import Alamofire

struct SearchOrg {
    var queryText: String
    var categories: [String]
    var tags: [String]
}

struct SearchRes: Decodable {
    var status: String
    var message: String
    var associations: [Association]
}

func search(search: SearchOrg) async throws -> [Association] {
    let url = apiURL + "/api/v1/createTag"
    let session = Session(interceptor:  AccessTokenAdapter());
    
    return try await withCheckedThrowingContinuation { continuation in
        let searchDict: [String: Any] = [
            "queryText": search.queryText,
            "categories": search.categories,
            "tags": search.tags
        ]
        
        session.request(url, method: .post, parameters: searchDict, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    if let jsonData = try? JSONSerialization.data(withJSONObject: data) {
                        do {
                            let res = try JSONDecoder().decode(SearchRes.self, from: jsonData)
                            continuation.resume(returning: res.associations) // Return the array of associations on success.
                        } catch {
                            print("Error decoding JSON: \(error)")
                            continuation.resume(throwing: error)
                        }
                    } else {
                        continuation.resume(returning: []) // Return an empty array if decoding fails.
                    }
                case .failure(let error):
                    print(error)
                    continuation.resume(throwing: error) // Throw an error on failure.
                }
            }
    }
}

