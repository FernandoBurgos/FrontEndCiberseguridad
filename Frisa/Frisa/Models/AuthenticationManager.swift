//
//  AuthenticationManager.swift
//  Frisa
//
//  Created by Alumno on 20/09/23.
//

import Foundation

class AuthenticationManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    // Function to simulate a successful login
    func login(accessToken: String) {
        // Save authentication token here
        KeychainService.saveAccessToken(accessToken)
        isLoggedIn = true // Set state to logged in
    }
    
    // Delete access token and logout
    func logout() {
        KeychainService.deleteAccessToken()
        isLoggedIn = false
    }
}
