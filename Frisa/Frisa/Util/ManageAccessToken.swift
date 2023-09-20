//
//  ManageAccessToken.swift
//  Frisa
//
//  Created by Alumno on 20/09/23.
//

import Foundation
import Security

struct KeychainService {
    private static let accessTokenKey = "AccessToken"

    static func saveAccessToken(_ accessToken: String) {
        if let data = accessToken.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: accessTokenKey,
                kSecValueData as String: data
            ]

            let status = SecItemAdd(query as CFDictionary, nil)

            if status != errSecSuccess {
                print("Error saving access token to Keychain: \(status)")
            }
        }
    }

    static func getAccessToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: accessTokenKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var data: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &data)

        if status == errSecSuccess, let tokenData = data as? Data, let token = String(data: tokenData, encoding: .utf8) {
            return token
        } else {
            return nil
        }
    }

    static func deleteAccessToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: accessTokenKey
        ]

        let status = SecItemDelete(query as CFDictionary)

        if status != errSecSuccess {
            print("Error deleting access token from Keychain: \(status)")
        }
    }
}
