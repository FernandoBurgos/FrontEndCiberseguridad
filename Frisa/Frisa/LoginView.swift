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
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    @State private var accountToken: String = ""
    @State private var correo: String = "Correo"
    @State private var password: String = "Contraseña"
    @State private var input: String = ""
    @State private var showRegisterView: Bool = false
    
    func signIn(credential: AuthCredential) async throws -> User {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        
        return authDataResult.user
    }

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

    func apiLogin(accountToken: String) async throws -> LoginResponse? {
        let loginUrl = URL(string: apiURL + "/oauth2/login")!
        
        var loginRequest = URLRequest(url: loginUrl)
        loginRequest.httpMethod = "POST"
        loginRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        loginRequest.httpBody = try? JSONEncoder().encode(["accountToken": accountToken])
        
        do {
            let (data, response) = try await URLSession.shared.data(for: loginRequest)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let value = try JSONDecoder().decode(LoginResponse.self, from: data)
                return value
            } else {
                throw URLError(.badServerResponse)
            }
        } catch {
            // Handle errors here
            print("Error:", error)
            return nil
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                Image("icon").resizable().frame(width: 450.0, height: 450.0) //393 x 310
                Spacer()
                HStack{
                    //Para mover el texto hacia arriba y luego un poco a la izq.
                    Text("¡Bienvenido!").frame(maxWidth: .infinity, alignment: .leading).offset(y:-60).padding(10).font(.system(size: 30, weight: .bold)) //offset mover bienvenido
                }
                /*Form {
                 TextField("Correo", text: $input ).frame(maxWidth: .infinity).padding(10)
                 }*/
                ZStack(alignment: .leading) {
                    VStack(spacing: 20) {
                        /*TextField("Correo Electrónico", text: $input).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                         .frame(height: 52)
                         .frame(maxWidth: 327) //para que quede igual que en figma
                         .padding(10)
                         .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                         .cornerRadius(8)
                         .frame(height: 52)
                         SecureField("Contraseña", text: $password).font(.system(size:20, weight: .bold)).foregroundColor(.black).frame(height: 52)
                         .frame(maxWidth: 327)
                         .padding(10)
                         .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                         .cornerRadius(8)
                         */
                        
                        Button {
                        } label: {
                            Text("¿Olvidó su contraseña?")
                                .padding(10).frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 10, weight: .bold)).foregroundColor(Color(red: 0, green: 25 / 255, blue: 255 / 255)).offset(y:-25) //moverlo hacia arriba
                                .offset(x:21)
                            //Color azul mismo al figma
                        }
                        /*Button{
                         }label: {
                         Text("Ingresar").padding().font(.system(size:20, weight: .bold))
                         .frame(maxWidth: 303)
                         .frame(height: 38)
                         .foregroundColor(.black)
                         .background(RoundedRectangle(
                         cornerRadius: 30).fill(Color(red: 253/255, green: 245/255, blue: 247/255) //mismo color que figma
                         )
                         .stroke(.black, lineWidth: 1)
                         )
                         .offset(y:-40) // mover ingresar
                         
                         }*/
                        GoogleSignInButton {
                            
                            Task {
                                do {
                                    // Get google account token
                                    let credentials = try await signInGoogle()
                                    let user = try await signIn(credential: credentials)
                                    let accountToken = try await user.getIDToken()
                                    
                                    // Attempt login
                                    if let loginResponse = try await apiLogin(accountToken: accountToken) {
                                        authenticationManager.login(accessToken: loginResponse.accessToken)
                                    } else {
                                        showRegisterView = true
                                    }
                                } catch {
                                    print(error)
                                }
                            }
                        }
                        .offset(y:-40)
                        .padding(10)
                    }
                }
                .offset(y:-60) // mover botones de textfield
                
                /*Rectangle() //linea separadora
                 .frame(height: 1)
                 .foregroundColor(Color.black)
                 .padding(.horizontal, 0)
                 .offset(y: -30) // mover arriba o abajo la línea
                 // boton de registrarse
                 Button {
                 }label: {
                 Text("Regístrate").font(.system(size:20, weight: .bold))
                 .frame(maxWidth: 152)
                 .frame(height: 74)
                 .foregroundColor(.black)
                 .background(RoundedRectangle(
                 cornerRadius: 30).fill(Color(red: 253/255, green: 247/255, blue: 173/255) //mismo color que figma
                 )
                 .stroke(.black, lineWidth: 1)
                 )
                 }
                 .offset(y:-30)*/
            }.sheet(isPresented: $showRegisterView, content: { RegisterView(accountToken: accountToken) })
        }
    }
}

#Preview {
    LoginView()
}
