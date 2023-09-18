//
//  FrisaApp.swift
//  Frisa
//
//  Created by Fernando Martínez on 17/09/23.
//

import SwiftUI
import SwiftData

@main
struct FrisaApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
