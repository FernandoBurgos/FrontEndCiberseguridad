//
//  ContentView.swift
//  Yco
//
//  Created by Fernando Martínez on 17/09/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    var body: some View {
        if authenticationManager.isLoggedIn {
            // Display the main app views
            //MainAppView()
            //RegisterView(accountToken: "")
            //SearchView()
            //orgView2()
        } else {
            // Display the login view
            //LoginView()
            //MainAppView()
            //RegisterView(accountToken: "")
            //SearchView()
            //orgView2()
        }
    }
}


#Preview {
    ContentView()
}
