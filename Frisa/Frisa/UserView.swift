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
    @State var clicked: Bool = false
    @State var Orgname: String = ""
    @State var desc: String = ""
    @State var email: String = ""
    @State var newtag: Bool = false
    @State var changeName: Bool = false
    @State var tagarr: [Tag] = []
    @State var categorySelected: String = "Selecciona una categoría"
    @State var assocData: Association = Association()
    @State var assocId: String = ""
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    var body: some View {
        NavigationStack{
            GeometryReader{ geo in
                VStack{
                    Text("")
                        .task {
                                do{
                                    assocData = try await isOwner()
                                    assocId = assocData._id
                                } catch{
                                    print(error)
                                }
                        }

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
                                OrgRegister(clicked: $clicked, orga: $Orgname, desc: $desc, email: $email, newTag: $newtag, tagsarr: $tagarr, categorySelected: $categorySelected)
                            }
                        }
                        HStack{
                            NavigationLink("Actualizar datos"){
                                
                                extraInfoView(assocId: $assocId)
                            }
                        }
                        
                    }
                    .listStyle(.insetGrouped)
                    Button{
                        logout()
                    }label: {
                        Text("Cerrar Sesión")
                            
                    }
                    .tint(.red)
                    menuBarView()
                    .frame(height: 50)
                }
                .navigationBarBackButtonHidden(true)
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
