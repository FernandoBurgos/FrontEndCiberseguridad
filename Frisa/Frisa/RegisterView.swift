//
//  Register.swift
//  Frisa
//
//  Created by Fernando Martínez on 17/09/23.
//

import SwiftUI

struct RegisterView: View {
    @State var accountToken: String
    //@State private var cancellables: Set<AnyCancellable> = []
    @State private var usuario: String = ""
    @State private var orga: String = ""
    @State private var desc: String = ""
    @State private var email: String = ""
    @State private var isAgreed: Bool = false
    @State private var newTag: Bool = false
    @State private var showUsernameError: Bool = false
    @State private var categorySelected: String = "Selecciona una categoría"
    
    @State var tag: String
    @State var tagsarr: [Tag]
    
    
    
    func registerUser(accountToken: String, username: String) async throws -> LoginResponse? {
        let registerUrl = URL(string: apiURL + "/oauth2/register")!
        
        var registerRequest = URLRequest(url: registerUrl)
        registerRequest.httpMethod = "POST"
        registerRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        registerRequest.httpBody = try? JSONEncoder().encode(["accountToken": accountToken, "username": username])
        
        do {
            let (data, response) = try await URLSession.shared.data(for: registerRequest)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let value = try JSONDecoder().decode(LoginResponse.self, from: data)
                print("User registered:", value)
                return value // Return the response if registration is successful
            } else {
                throw URLError(.badServerResponse)
            }
        } catch {
            // Handle errors here
            print("Error:", error)
            throw error
        }
    }
    var body: some View {
        HStack {
            //Spacer()
            //    .frame(width: 22)
            VStack {
                Text("Regístrate")
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                Text("Crea una cuenta para comenzar")
                    .font(.system(size: 19, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                    .foregroundColor(Color(red: 115/255, green: 115/255, blue: 115/255))
                VStack(alignment: .center, spacing: 10) {
                    TextField("Tu Nombre", text: $usuario).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                    if showUsernameError {
                        Text("Los nombre de usuario requieren minimo 2 characteres")
                            .foregroundStyle(Color.red)
                    }
                    Toggle(isOn: $isAgreed) {
                        Text("¿Buscas registrar una organización?").font(.system(size:16, weight: .bold))
                    }.foregroundColor(.gray)
                        .toggleStyle(CheckboxStyle())
                        .padding(.top, 20)
                    if isAgreed {
                        OrgRegister(orga: $orga, desc: $desc, email: $email, newTag: $newTag, tagsarr: $tagsarr, categorySelected: $categorySelected)
                    }
                    Button {
                        if usuario.count < 2 {
                            showUsernameError = true
                            return
                        }
                        Task {
                            do {
                                if let registerResponse = try await registerUser(accountToken: accountToken, username: usuario) {
                                    KeychainService.saveAccessToken(registerResponse.accessToken)
                                    
                                    
                                }
                            } catch {
                                print(error)
                            }
                        }
                        
                    } label: {
                        Text("Registrarse").padding().font(.system(size:20, weight: .bold))
                            .frame(maxWidth: 303)
                            .frame(height: 38)
                            .foregroundColor(.black)
                            .background(RoundedRectangle(
                                cornerRadius: 30).fill(Color(red: 253/255, green: 245/255, blue: 247/255)).stroke(.black, lineWidth: 1))
                    }
                    .padding(.top, 10)
                }
            }
        }
    }
    
    struct CheckboxStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(configuration.isOn ? .accentColor : .gray)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
                
                configuration.label
            }
        }
    }
}

#Preview {
    RegisterView(accountToken: "", tag: "", tagsarr: [])
}
