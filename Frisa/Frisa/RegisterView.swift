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
    @State private var isAgreed: Bool = true
    @State private var newTag: Bool = false
    /*
    @State private var isAgreedAsistenciales: Bool = false
    @State private var isAgreedBecantes: Bool = false
    @State private var isAgreedCultura: Bool = false
    @State private var isAgreedEcologia: Bool = false
    @State private var isAgreedEducativa: Bool = false
    @State private var isAgreedInvestigacion: Bool = false
     */
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
            Spacer()
                .frame(width: 22)
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
                VStack(alignment: .leading, spacing: 10) {
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
                        TextField("Nombre de Organización", text: $orga).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                            .frame(height: 52)
                            .frame(maxWidth: 327) //para que quede igual que en figma
                            .padding(10)
                            .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                            .cornerRadius(8)
                        
                        TextField("Breve Descripción", text: $desc).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                            .frame(height: 52)
                            .frame(maxWidth: 327) //para que quede igual que en figma
                            .padding(10)
                            .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                            .cornerRadius(8)
                        
                        
                        Text("Selecciona con qué categoría(s) consideras\nque tu organización encaja.").font(.system(size: 14, weight: .bold)).foregroundColor(.gray)
                        
                        /* VStack {
                         HStack{
                         Toggle(isOn: $isAgreedAsistenciales) {
                         Text("Asistenciales").font(.system(size:16, weight: .bold)).foregroundColor(.gray)
                         }.offset(x:-2)
                         .toggleStyle(CheckboxStyle())
                         .offset(x:-10)
                         .offset(y:10)
                         Toggle(isOn: $isAgreedBecantes) {
                         Text("Becantes").font(.system(size:16, weight: .bold)).foregroundStyle(.gray)
                         }
                         .toggleStyle(CheckboxStyle())
                         .offset(x: 20)
                         .offset(y: 10)
                         }
                         .offset(x:17)
                         HStack{
                         Toggle(isOn: $isAgreedCultura) {
                         Text("Cultura").font(.system(size:16, weight: .bold))
                         }.offset(x:-28)
                         .toggleStyle(CheckboxStyle())
                         .offset(x:-10)
                         .offset(y:10).foregroundColor(.gray)
                         Toggle(isOn: $isAgreedEcologia) {
                         Text("Ecología").font(.system(size:16, weight: .bold))
                         }
                         .toggleStyle(CheckboxStyle())
                         .offset(x: 40)
                         .offset(y: 10)
                         .foregroundColor(.gray)
                         }
                         .offset(x:17)
                         HStack{
                         Toggle(isOn: $isAgreedEducativa) {
                         Text("Educativa").font(.system(size:16, weight: .bold))
                         }
                         .toggleStyle(CheckboxStyle())
                         .offset(x:-10)
                         .offset(y:10)
                         .foregroundColor(.gray)
                         Toggle(isOn: $isAgreedInvestigacion) {
                         Text("Investigación").font(.system(size:16, weight: .bold))
                         }
                         .toggleStyle(CheckboxStyle())
                         .offset(x: 50)
                         .offset(y: 10)
                         .foregroundColor(.gray)
                         }.offset(x:17)
                         } */
                        
                        Menu{
                            Button{
                                categorySelected = "Asistenciales"
                            }label: {
                                Text("Asistenciales")
                            }
                            Button{
                                categorySelected = "Becantes"
                            }label: {
                                Text("Becantes")
                            }
                            Button{
                                categorySelected = "Cultura"
                            }label: {
                                Text("Cultura")
                            }
                            Button{
                                categorySelected = "Ecología"
                            }label: {
                                Text("Ecologia")
                            }
                            Button{
                                categorySelected = "Educativa"
                            }label: {
                                Text("Educativa")
                            }
                            Button{
                                categorySelected = "Investigación"
                            }label: {
                                Text("Investigación")
                            }
                        } label: {
                            Text(categorySelected)
                                .frame(width: 200, height: 40)
                                .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke(style: StrokeStyle()))
                        }
                        .padding(.leading, 60)
                        
                        if tagsarr.count < 1{
                            HStack{
                                Spacer()
                                    .frame(width: 100)
                                Button{
                                    newTag.toggle()
                                }
                            label: {
                                Label("New tag", systemImage: "plus")
                            }
                                Spacer()
                            }
                            .buttonStyle(.bordered)
                        } else {
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(tagsarr){tag in
                                        Text(tag.name)
                                            .frame(width: 120, height: 40)
                                            .overlay(RoundedRectangle(cornerRadius: 30)
                                                .stroke(style: StrokeStyle()))
                                    }
                                    Button{
                                        newTag.toggle()
                                    }label: {
                                        Image(systemName: "plus")
                                    }
                                }
                            }
                            .frame(alignment: .center)
                        }
                        
                        Text("Los administradores se pondrán en contacto\ncontigo para el registro de la organización.").font(.system(size:14, weight: .bold)).foregroundColor(.gray).padding(.top, 15)
                    }
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
                .padding(.trailing, 40)
            }
            .sheet(isPresented: $newTag, content: {
                Frisa.newTag(tag: $tag, tagsarr: $tagsarr, newTag: $newTag)
                    .presentationDetents([.height(200)])
            })
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

#Preview {
    RegisterView(accountToken: "", tag: "", tagsarr: [])
}
