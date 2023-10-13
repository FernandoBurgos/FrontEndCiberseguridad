//
//  ContentView.swift
//  Yco
//
//  Created by Fernando Martínez on 17/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    var body: some View {
        Group {
            if isLoggedIn {
                MainAppView()
//              resultsView()
            } else {
                LoginView()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
            self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
    }
}

#Preview {
    ContentView()
}
