//
//  FrisaApp.swift
//  Frisa
//
//  Created by Fernando Martínez on 17/09/23.
//

import SwiftUI
import SwiftData

import FirebaseCore

@main
struct FrisaApp: App {
@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationManager = AuthenticationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authenticationManager)
        }
        .modelContainer(for: Item.self)
    }
}
