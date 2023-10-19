//
//  extraInfoView.swift
//  Frisa
//
//  Created by Alumno on 17/10/23.
//

import SwiftUI
import iPhoneNumberField

struct extraInfoView: View {
    
    @State var newDesc: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var whatsapp: String = ""
    @State var face: String = ""
    @State var insta: String = ""
    @State var youtube: String = ""
    @State var linkedin: String = ""
    @State var isAgreed: Bool = false
    @Binding var assocId: String
    
    var body: some View {
        NavigationStack{
            VStack{
                Text(assocId)
                TextField("Nueva descripción", text: $newDesc).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                    .frame(height: 52)
                    .frame(maxWidth: 327) //para que quede igual que en figma
                    .padding(10)
                    .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                    .cornerRadius(8)
                
                TextField("Correo Electrónico", text: $email).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                    .frame(height: 52)
                    .frame(maxWidth: 327) //para que quede igual que en figma
                    .padding(10)
                    .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                    .cornerRadius(8)
                
                iPhoneNumberField("Teléfono", text: $phone)
                    .font(UIFont(size: 20, weight: .bold, design: .rounded))
                    .flagHidden(false)
                    .flagSelectable(true)
                    .frame(height: 52)
                    .frame(maxWidth: 327) //para que quede igual que en figma
                    .padding(10)
                    .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                    .cornerRadius(8)
                
                iPhoneNumberField("WhatsApp", text: $whatsapp)
                    .font(UIFont(size: 20, weight: .bold, design: .rounded))
                    .frame(height: 52)
                    .frame(maxWidth: 327) //para que quede igual que en figma
                    .padding(10)
                    .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                    .cornerRadius(8)
                
                Toggle(isOn: $isAgreed) {
                    Text("¿Deseas agregar tus redes sociales?").font(.system(size:16, weight: .bold))
                }.foregroundColor(.gray)
                    .toggleStyle(CheckboxStyle())
                    .padding(.top, 20)
                
                if isAgreed {
                    
                    TextField("Facebook", text: $face).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                    
                    TextField("Instagram", text: $insta).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                    
                    TextField("Youtube", text: $youtube).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                    
                    TextField("LinkedIn", text: $linkedin).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                }
                
                Button{} label: {
                    Text("Actualizar datos")
                }
                .font(.system(size:20, weight: .bold))
                .frame(maxWidth: 303)
                .frame(height: 38)
                .foregroundColor(.black)
                .background(RoundedRectangle(
                    cornerRadius: 30).fill(Color(red: 253/255, green: 245/255, blue: 247/255)).stroke(.black, lineWidth: 1))
                .padding(.top, 20)
            }
        }
        .navigationTitle("Actualiza tus datos")
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
    extraInfoView(assocId: .constant(""))
}
