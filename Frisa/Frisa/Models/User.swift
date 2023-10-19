//
//  User.swift
//  Frisa
//
//  Created by Alumno on 10/10/23.
//

import Foundation
import Alamofire
import SwiftyJSON

struct UserUpdate {
    var username: String
}

struct assocRes: Decodable {
    var status: String
    var message: String
    var data: Association
}

func updateUser(user: UserUpdate) async throws -> Bool {
    let url = apiURL + "/api/v1/updateUsername"
    let session = Session(interceptor:  AccessTokenAdapter());
    return try await withCheckedThrowingContinuation { continuation in
            let userUpdateDict: [String: Any] = [
                "username": user.username
            ]
            session.request(url, method: .post, parameters: userUpdateDict, encoding: JSONEncoding.default)
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

func isOwner() async throws -> Association {
    let url = apiURL + "/api/v1/ownedAssociation"
    let session = Session(interceptor:  AccessTokenAdapter());
            return try await withCheckedThrowingContinuation { continuation in
                session.request(url, method: .get, encoding: JSONEncoding.default)
                    .responseJSON {response in
                        switch response.result {
                        case .success(let data):
                            print(data)
                            // Process the response data here if needed.
                            if let jsonData = try? JSONSerialization.data(withJSONObject: data){
                                do {
                                    let res = try JSONDecoder().decode(assocRes.self, from: jsonData)
                                    print(res)
                                    continuation.resume(returning: res.data)
                                } catch {
                                    print ("Error decoding JSON: \(error)")
                                    continuation.resume(throwing: error)
                                }
                            } else {
                                continuation.resume(returning: Association())
                            } // Return true on success.
                        case .failure(let error):
                            print(error)
                            continuation.resume(throwing: error) // Throw an error on failure.
                        }
                    }
            }

}
