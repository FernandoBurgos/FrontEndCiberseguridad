//
//  User.swift
//  Frisa
//
//  Created by Alumno on 10/10/23.
//

import Foundation
import Alamofire

struct UserUpdate {
    var username: String
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
