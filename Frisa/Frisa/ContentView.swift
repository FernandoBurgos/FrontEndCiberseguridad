//
//  ContentView.swift
//  Yco
//
//  Created by Fernando Martínez on 17/09/23.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    var body: some View {
        if isLoggedIn {
            // Display the main app views
            MainAppView()
        } else {
            // Display the login view
            LoginView()
        }
        Button("test") {
            print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
        }
    }
}


#Preview {
    ContentView()
}
