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
    @Binding var assocData: Association
    
    func resetValues() -> Void {
        newDesc = ""
        email = ""
        phone = ""
        whatsapp = ""
        face = ""
        insta = ""
        youtube = ""
        linkedin = ""
    }
    
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Nueva descripción", text: $newDesc).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                    .frame(height: 52)
                    .frame(maxWidth: 327) //para que quede igual que en figma
                    .padding(10)
                    .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                    .cornerRadius(8)
                    .foregroundStyle(.black)
                
                TextField("Correo Electrónico", text: $email).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                    .frame(height: 52)
                    .frame(maxWidth: 327) //para que quede igual que en figma
                    .padding(10)
                    .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                    .cornerRadius(8)
                    .foregroundStyle(.black)
                
                iPhoneNumberField("Teléfono", text: $phone)
                    .font(UIFont(size: 20, weight: .bold, design: .rounded))
                    .flagHidden(false)
                    .flagSelectable(true)
                    .frame(height: 52)
                    .frame(maxWidth: 327) //para que quede igual que en figma
                    .padding(10)
                    .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                    .cornerRadius(8)
                    .foregroundStyle(.black)
                
                iPhoneNumberField("WhatsApp", text: $whatsapp)
                    .font(UIFont(size: 20, weight: .bold, design: .rounded))
                    .frame(height: 52)
                    .frame(maxWidth: 327) //para que quede igual que en figma
                    .padding(10)
                    .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                    .cornerRadius(8)
                    .foregroundStyle(.black)
                
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
                        .foregroundStyle(.black)
                    
                    TextField("Instagram", text: $insta).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                        .foregroundStyle(.black)
                    
                    TextField("Youtube", text: $youtube).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                        .foregroundStyle(.black)
                    
                    TextField("LinkedIn", text: $linkedin).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                        .frame(height: 52)
                        .frame(maxWidth: 327) //para que quede igual que en figma
                        .padding(10)
                        .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                        .cornerRadius(8)
                        .foregroundStyle(.black)
                }
                
                Button{
                    Task{
                        newDesc = (newDesc == "" ? assocData.description ?? "" : newDesc)
                        email = (email == "" ? assocData.contact.email : email)
                        phone = (phone == "" ? assocData.contact.phone : phone)
                        whatsapp = (whatsapp == "" ? assocData.contact.whatsapp ?? "" : whatsapp)
                        face = (face == "" ? assocData.facebookURL ?? "" : face)
                        insta = (insta == "" ? assocData.instagramURL ?? "" : insta)
                        do{
                            print(face)
                            let newAssocInfo = OrgData(id: assocData._id, newDesc: self.newDesc, email: self.email, phone: self.phone, whatsapp: self.whatsapp, face: self.face, insta: self.insta, youtube: self.youtube, linkedin: self.linkedin)
                            
                            let posted = try await updateAssociation(org: newAssocInfo)
                            print(posted)
                            
                            resetValues()
                        } catch {
                            print(error)
                        }
                    }
                } label: {
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
    extraInfoView(assocData: .constant(Association(_id: "", name: "", description: "", ownerId: "", colaborators: [], logoURL: "", images: [], websiteURL: "", facebookURL: "", instagramURL: "", categoryId: "", tags: [], contact: Contact(email: "", phone: "", whatsapp: ""), address: "", verified: false)))
}
