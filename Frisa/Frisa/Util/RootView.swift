//
//  +View.swift
//  Frisa
//
//  Created by Alumno on 18/09/23.
//

import SwiftUI

extension View {
    func getRootViewController() -> UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return.init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return.init()
        }
        return root
    }
}
