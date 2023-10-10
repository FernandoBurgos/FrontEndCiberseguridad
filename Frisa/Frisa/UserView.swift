//
//  UserView.swift
//  Frisa
//
//  Created by Alumno on 25/09/23.
//

import SwiftUI
import PhotosUI

struct UserView: View {
    
    @State var username: String = "Sin Nombre"
    @State var Orgname: String = ""
    @State var desc: String = ""
    @State var email: String = ""
    @State var newtag: Bool = false
    @State var changeName: Bool = false
    @State var tagarr: [Tag] = []
    @State var categorySelected: String = "Selecciona una categoría"
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    var body: some View {
        NavigationStack{
            GeometryReader{ geo in
                VStack{
                    

                    if let avatarImage {
                        avatarImage
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(style: StrokeStyle()))
                        PhotosPicker("Actualizar imagen", selection: $avatarItem, matching: .images)

                    }
                    else {
                        Image("ProfilePlaceholder")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(style: StrokeStyle()))
                        PhotosPicker("Seleccionar imagen", selection: $avatarItem, matching: .images)
                    }
                    Text(username)
                        .font(.title)
                    
                    List{
                        HStack{
                            Button{
                                changeName.toggle()
                            }label: {
                                Text("Cambiar nombre")
                            }
                            .tint(.black)
                        }
                        HStack{
                            NavigationLink("Favoritos"){
                                favoriteView()
                            }
                        }
                        HStack{
                            NavigationLink("Registra tu organización"){
                                OrgRegister(orga: $Orgname, desc: $desc, email: $email, newTag: $newtag, tagsarr: $tagarr, categorySelected: $categorySelected)
                            }
                        }
                        
                    }
                    .listStyle(.insetGrouped)
                    Button{}label: {
                        Text("Cerrar Sesión")
                    }
                    .tint(.red)
                    ZStack{
                        Color(red: 253/255, green: 247/255, blue: 173/255)
                        HStack(spacing: geo.size.width/3) {
                            //mover los icons
                            Button {
                            } label: {
                                Image(systemName: "bell").resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .clipped()
                                
                            }
                            Button {
                            } label: {
                                Image(systemName: "bell").resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .clipped()
                            }
                            Button {
                            } label: {
                                Image(systemName: "bell").resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .clipped()
                                
                            }
                        }
                    }
                    .frame(height: 50)
                }
                .onChange(of: avatarItem) { _ in
                    Task {
                        if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                avatarImage = Image(uiImage: uiImage)
                                return
                            }
                        }

                        print("Failed")
                    }
                }
                .sheet(isPresented: $changeName, content: {
                    Frisa.UserConfig(name: $username, changeName: $changeName)
                        .presentationDetents([.height(300)])
                })
                
            }
        }
    }
}

#Preview {
    UserView()
}
