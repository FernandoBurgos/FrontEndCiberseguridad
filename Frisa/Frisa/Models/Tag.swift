//
//  Tag.swift
//  Frisa
//
//  Created by Alumno on 25/09/23.
//

import Foundation
import Alamofire

struct Tag {
    var name: String
}

func createTag(tag: Tag) async throws -> Bool {
    let url = apiURL + "/api/v1/createTag"
    let session = Session(interceptor:  AccessTokenAdapter());
    return try await withCheckedThrowingContinuation { continuation in
        let tagDict: [String: Any] = [
            "name":tag.name
        ]
        session.request(url, method: .post, parameters: tagDict, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        print(data)
                        // Process the response data here if needed.
                        continuation.resume(returning: true) // Return true on success.
                    case .failure(let error):
                        print(error)
                        continuation.resume(throwing: error) // Throw an error on failure.
                    }
                }
        }
}

func getTag(id: String) async throws -> Bool {
    let url = apiURL + "/api/v1/getTag/\(id)"
    let session = Session(interceptor:  AccessTokenAdapter());
    return try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: .get)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        print(data)
                        // Process the response data here if needed.
                        continuation.resume(returning: true) // Return true on success.
                    case .failure(let error):
                        print(error)
                        continuation.resume(throwing: error) // Throw an error on failure.
                    }
                }
        }
}
