//
//  Login.swift
//  Frisa
//
//  Created by Fernando Martínez on 17/09/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth
import Firebase
import Combine
import UIKit

struct LoginView: View {
    @State private var accountToken: String = ""
    @State private var correo: String = "Correo"
    @State private var password: String = "Contraseña"
    @State private var input: String = ""
    @State private var showRegisterView: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn = false

    func signInGoogle() async throws -> AuthCredential { // Change the return type here
        let topVc = getRootViewController()
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVc)
        
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        return credential // Return the credential here
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                Image("Logo2").resizable().frame(width: 450.0, height: 450.0) //393 x 310
                VStack{
                    //Para mover el texto hacia arriba y luego un poco a la izq.
                    Text("¡Bienvenido!").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 30, weight: .bold))
                    Text("Inicia sesión").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 16, weight: .light))
                }.padding(.horizontal, 20)
                VStack(alignment: .leading) {
                    VStack(spacing: 10) {
                        GoogleSignInButton {
                            Task {
                                do {
                                    // Get google account token
                                    let credentials = try await signInGoogle()
                                    let user = try await signIn(credential: credentials)
                                    let accountToken = try await user.getIDToken()
                                    
                                    // Attempt login
                                    let loginResponse = try await apiLogin(accountToken: accountToken)
                                    
                                    print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
                                    if !loginResponse {
                                        showRegisterView = true
                                    }
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }.sheet(isPresented: $showRegisterView, content: { RegisterView(accountToken: accountToken, tag: "", tagsarr: []) })
        }
    }
}

#Preview {
    LoginView()
}
