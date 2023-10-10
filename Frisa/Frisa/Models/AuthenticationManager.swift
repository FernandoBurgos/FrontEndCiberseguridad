//
//  AuthenticationManager.swift
//  Frisa
//
//  Created by Alumno on 20/09/23.
//

import Foundation
import FirebaseAuth
import Alamofire

func signIn(credential: AuthCredential) async throws -> User {
    let authDataResult = try await Auth.auth().signIn(with: credential)
    
    return authDataResult.user
}

func apiLogin(accountToken: String) async throws -> Bool {
    let loginUrl = URL(string: apiURL + "/oauth2/login")!
    
    var loginRequest = URLRequest(url: loginUrl)
    loginRequest.httpMethod = "POST"
    loginRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    loginRequest.httpBody = try? JSONEncoder().encode(["accountToken": accountToken])
    
    do {
        let (data, response) = try await URLSession.shared.data(for: loginRequest)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            let value = try JSONDecoder().decode(LoginResponse.self, from: data)
            KeychainService.saveAccessToken(value.accessToken)
            KeychainService.saveRefreshToken(value.refreshToken)
            // Set state to logged in
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            return true
        } else {
            return false
        }
    } catch {
        // Handle errors here
        print("Error:", error)
        return false
    }
}

// Delete access token and logout
func logout() {
    KeychainService.deleteAccessToken()
    KeychainService.deleteRefreshToken()
    UserDefaults.standard.set(false, forKey: "isLoggedIn")
}
