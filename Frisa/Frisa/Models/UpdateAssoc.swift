//
//  UpdateAssoc.swift
//  Frisa
//
//  Created by Alumno on 19/10/23.
//

import Foundation

import Alamofire

struct OrgData {
    var id: String
    var newDesc: String
    var email: String
    var phone: String
    var whatsapp: String
    var face: String
    var insta: String
    var youtube: String
    var linkedin: String
}

func updateAssociation(org: OrgData) async throws -> Bool {
    let url = apiURL + "/api/v1/updateAssociation/\(org.id)"
    let session = Session(interceptor:  AccessTokenAdapter());
    return try await withCheckedThrowingContinuation { continuation in
            let orgUpdateDict: [String: Any] = [
                "description": org.newDesc,
                "email": org.email,
                "phone": org.phone,
                "whatsapp": org.whatsapp,
                "facebook": org.face,
                "instagram": org.insta,
                "youtube": org.youtube,
                "linkedin": org.linkedin
            ]
            session.request(url, method: .put, parameters: orgUpdateDict, encoding: JSONEncoding.default)
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
