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
    private static let refreshTokenKey = "RefreshToken" // Add this line

    static func saveAccessToken(_ accessToken: String) {
        saveToken(accessToken, for: accessTokenKey)
    }

    static func saveRefreshToken(_ refreshToken: String) {  // New function
        saveToken(refreshToken, for: refreshTokenKey)
    }

    static func getAccessToken() -> String? {
        return getToken(for: accessTokenKey)
    }

    static func getRefreshToken() -> String? { // New function
        return getToken(for: refreshTokenKey)
    }

    static func deleteAccessToken() {
        deleteToken(for: accessTokenKey)
    }

    static func deleteRefreshToken() { // New function
        deleteToken(for: refreshTokenKey)
    }

    private static func saveToken(_ token: String, for key: String) {
        if let data = token.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]

            let status = SecItemAdd(query as CFDictionary, nil)

            if status != errSecSuccess {
                print("Error saving \(key) to Keychain: \(status)")
            }
        }
    }

    private static func getToken(for key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
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

    private static func deleteToken(for key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)

        if status != errSecSuccess {
            print("Error deleting \(key) from Keychain: \(status)")
        }
    }
}
