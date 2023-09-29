//
//  OrgRegister.swift
//  Frisa
//
//  Created by Alumno on 28/09/23.
//

import SwiftUI

struct OrgRegister: View {
    
    @Binding var orga: String
    @Binding var desc: String
    @Binding var email: String
    @Binding var newTag: Bool
    @Binding var tagsarr: [Tag]
    @Binding var categorySelected: String
    @State var tag: String = ""
    
    var body: some View {
        VStack{
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
            
            TextField("Correo Electrónico", text: $email).font(.system(size:20, weight: .bold)).foregroundColor(.black)
                .frame(height: 52)
                .frame(maxWidth: 327) //para que quede igual que en figma
                .padding(10)
                .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                .cornerRadius(8)
            
            
            Text("Selecciona con qué categoría(s) consideras\nque tu organización encaja.").font(.system(size: 14, weight: .bold)).foregroundColor(.gray)
            HStack{
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
            }
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
                        .frame(width: 100)
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
        .sheet(isPresented: $newTag, content: {
            Frisa.newTag(tag: $tag, tagsarr: $tagsarr, newTag: $newTag)
                .presentationDetents([.height(200)])
        })
    }
}
#Preview {
    OrgRegister(orga: .constant(""), desc: .constant(""), email: .constant(""), newTag: .constant(false), tagsarr: .constant([]), categorySelected: .constant("Selecciona una categoría"))
}
