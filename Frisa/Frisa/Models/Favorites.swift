//
//  Favorites.swift
//  Frisa
//
//  Created by Alumno on 19/10/23.
//

import Foundation
import Alamofire

struct SavedAssoc:Decodable {
    var id: String
    var name: String
    var description: String
    var logoURL: String
    var rating: Int?
}

struct saResults:Decodable {
    var status:String
    var count:Int
    var savedAssociations:[SavedAssoc]
}

func saveAssoc(id: String) async throws -> Bool {
    let url = apiURL + "/api/v1/saveAssociation"
    let session = Session(interceptor:  AccessTokenAdapter());
    return try await withCheckedThrowingContinuation { continuation in
        let body: [String: Any] = [
                "assocId": id
            ]
        session.request(url, method: .post, parameters: body, encoding: JSONEncoding.default)
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

func unsaveAssoc(id: String) async throws -> Bool {
    let url = apiURL + "/api/v1/unsaveAssociation"
    let session = Session(interceptor:  AccessTokenAdapter());
    return try await withCheckedThrowingContinuation { continuation in
        let body: [String: Any] = [
                "assocId": id
            ]
        session.request(url, method: .delete, parameters: body, encoding: JSONEncoding.default)
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

func getFavorites() async throws -> [SavedAssoc] {
    let url = apiURL + "/api/v1/getSavedAssociations"
    let session = Session(interceptor:  AccessTokenAdapter());
    return try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: .get)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        if let jsonData = try? JSONSerialization.data(withJSONObject: data) {
                            do {
                                let res = try JSONDecoder().decode(saResults.self, from: jsonData)
                                print(res)
                                continuation.resume(returning: res.savedAssociations) // Return the array of associations on success.
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
