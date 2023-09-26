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
            RegisterView(accountToken: "", tag: "", tagsarr: [])
            //SearchView()
            //orgView2()
        } else {
            // Display the login view
            //LoginView()
            RegisterView(accountToken: "", tag: "", tagsarr: [])
            //SearchView()
            //orgView2()
            //MainAppView()
        }
    }
}


#Preview {
    ContentView()
}
