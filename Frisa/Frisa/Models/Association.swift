//
//  User.swift
//  Frisa
//
//  Created by Alumno on 10/10/23.
//

import Foundation
import Alamofire

struct Colaborator {
    let userId: String
    let perms: Int
}

struct Contact {
    let email: String
    let phone: String
    let whatsapp: String?
}

struct Association {
    let name: String
    let description: String?
    let ownerId: String
    let colaborators: [Colaborator]
    let logoURL: String?
    let images: [String]
    let websiteURL: String?
    let facebookURL: String?
    let instagramURL: String?
    let categoryId: String
    let tags: [String]
    let contact: Contact
    let address: String
    let verified: Bool
}


func createAssoc(assoc: Association) async throws -> Bool {
    let url = apiURL + "/api/v1/createAssociation"
    let session = Session(interceptor:  AccessTokenAdapter());
    return try await withCheckedThrowingContinuation { continuation in
        let assocDict: [String: Any] = [
                "name": assoc.name,
                "description": assoc.description ?? "",
                "ownerId": assoc.ownerId,
                "colaborators": assoc.colaborators.map { [
                    "userId": $0.userId,
                    "perms": $0.perms
                ] },
                "logoURL": assoc.logoURL ?? "",
                "images": assoc.images,
                "websiteURL": assoc.websiteURL ?? "",
                "facebookURL": assoc.facebookURL ?? "",
                "instagramURL": assoc.instagramURL ?? "",
                "categoryId": assoc.categoryId,
                "tags": assoc.tags,
                "contact": [
                    "email": assoc.contact.email,
                    "phone": assoc.contact.phone,
                    "whatsapp": assoc.contact.whatsapp ?? ""
                ],
                "address": assoc.address,
                "verified": assoc.verified
            ]
        session.request(url, method: .post, parameters: assocDict, encoding: JSONEncoding.default)
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

func getAssoc(id: String) async throws -> Bool {
    let url = apiURL + "/api/v1/getAssociation/\(id)"
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

func deleteAssoc(id: String) async throws -> Bool {
    let url = apiURL + "/api/v1/deleteAssociation/\(id)"
    let session = Session(interceptor:  AccessTokenAdapter());
    return try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: .delete)
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

func updateAssoc(assoc: Association, id:String) async throws -> Bool {
    let url = apiURL + "/api/v1/updateAssociation/\(id)"
    let session = Session(interceptor:  AccessTokenAdapter());
    return try await withCheckedThrowingContinuation { continuation in
        let assocDict: [String: Any] = [
                "name": assoc.name,
                "description": assoc.description ?? "",
                "ownerId": assoc.ownerId,
                "colaborators": assoc.colaborators.map { [
                    "userId": $0.userId,
                    "perms": $0.perms
                ] },
                "logoURL": assoc.logoURL ?? "",
                "images": assoc.images,
                "websiteURL": assoc.websiteURL ?? "",
                "facebookURL": assoc.facebookURL ?? "",
                "instagramURL": assoc.instagramURL ?? "",
                "categoryId": assoc.categoryId,
                "tags": assoc.tags,
                "contact": [
                    "email": assoc.contact.email,
                    "phone": assoc.contact.phone,
                    "whatsapp": assoc.contact.whatsapp ?? ""
                ],
                "address": assoc.address,
                "verified": assoc.verified
            ]
        session.request(url, method: .put, parameters: assocDict, encoding: JSONEncoding.default)
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