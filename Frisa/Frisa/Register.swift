//
//  Register.swift
//  Frisa
//
//  Created by Fernando Martínez on 17/09/23.
//

import SwiftUI

struct Register: View {
    @State private var correo: String = ""
    @State private var password: String = ""
    @State private var usuario: String = ""
    @State private var orga: String = ""
    @State private var desc: String = ""
    @State private var isAgreed: Bool = false
    @State private var isAgreedAsistenciales: Bool = false
    @State private var isAgreedBecantes: Bool = false
    @State private var isAgreedCultura: Bool = false
    @State private var isAgreedEcologia: Bool = false
    @State private var isAgreedEducativa: Bool = false
    @State private var isAgreedInvestigacion: Bool = false
    
    var body: some View {
        VStack {
            Text("Regístrate")
                .offset(y:-210)
                .offset(x:-100)
                .font(.system(size: 30, weight: .bold))
            Text("Crea una cuenta para comenzar")
                .offset(y:-210)
                .offset(x:-30)
                .font(.system(size: 19, weight: .bold))
                .foregroundColor(Color(red: 115/255, green: 115/255, blue: 115/255))
            ZStack(alignment: .leading) {
                VStack(spacing: 30) {
                    TextField("Usuario", text: $usuario).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                        .frame(height: 52)
                    
                    /*TextField("Correo Electrónico", text: $correo).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                        .frame(height: 52)
                    
                    SecureField("Contraseña", text: $password).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                        .frame(height: 52)
                     */
                    
                    Toggle(isOn: $isAgreed) {
                        Text("¿Buscas registrar una organización?").font(.system(size:16, weight: .bold))
                    }.foregroundColor(.gray)
                    .toggleStyle(CheckboxStyle())
                    .offset(x:-10) //mover checkbox
                }
                .offset(y:-180)
                ZStack(alignment:.leading) {
                    VStack(spacing:57) {
                        TextField("Nombre de Organización", text: $orga).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                            .frame(height: 52)
                            .frame(maxWidth: 327) //para que quede igual que en figma
                            .padding(10)
                            .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                            .cornerRadius(8)
                            .frame(height: 25)
                        
                        TextField("Breve Descripción", text: $desc).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                            .frame(height: 52)
                            .frame(maxWidth: 327) //para que quede igual que en figma
                            .padding(10)
                            .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                            .cornerRadius(8)
                            .frame(height: 25)
                    }
                    .offset(y:45) // mover cuadritos de abajo
                    Text("Selecciona con qué categoría(s) consideras\nque tu organización encaja.").offset(y:-11).font(.system(size: 14, weight: .bold)).offset(x:1, y:150).foregroundColor(.gray)
                    VStack {
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
                        .offset(y:180)
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
                        .offset(y:175)
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
                        }
                        .offset(y:170)
                        .offset(x:17)
                    }
                    .offset(y:16) // mover TODOS los check
                }
                Text("Los administradores se pondrán en contacto\ncontigo para el registro de la organización.").offset(y:270).font(.system(size:14, weight: .bold)).foregroundColor(.gray)
                
                Button{
                }label: {
                    Text("Registrarse").padding().font(.system(size:20, weight: .bold))
                        .frame(maxWidth: 303)
                        .frame(height: 38)
                        .foregroundColor(.black)
                        .background(RoundedRectangle(
                            cornerRadius: 30).fill(Color(red: 253/255, green: 245/255, blue: 247/255) //mismo color que figma
                        )
                            .stroke(.black, lineWidth: 1)
                                    
                    )
                        .offset(y: 320) // mover ingresar
                        .offset(x:20)
                }
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

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}



#Preview {
    Register()
}
