//
//  SearchView.swift
//  Frisa
//
//  Created by Alumno on 19/09/23.
//

import SwiftUI

struct SearchView: View {
    @State var items: [String] = ["Categoria 1", "Categoria 2", "Categoria 3", "Categoria 4", "Categoria 5", "Categoria 6", "Categoria 7", "Categoria 8"]
    @State var Selections: [String] = []
    @State private var busqueda: String = ""
    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                ZStack{
                    VStack{
                        VStack{
                            VStack{
                                Text("Personaliza tu búsqueda")
                                    .font(.largeTitle)
                                Text("Escoge según tus necesidades")
                                    .font(.caption)
                            }
                            .padding(.bottom, 50)
                            Text("Buscar por nombre")
                            HStack{
                                Image(systemName: "magnifyingglass")
                                TextField("Buscar", text: $busqueda)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            List{
                                Section{
                                    ForEach(items, id: \.self){item in
                                        Button{
                                            if Selections.contains(item){
                                                if let index = Selections.firstIndex(of: item){
                                                    Selections.remove(at: index)
                                                }
                                            }else{
                                                Selections.append(item)
                                            }
                                        } label: {
                                            HStack{
                                                Text(item)
                                                if Selections.contains(item){
                                                    Spacer()
                                                    Image(systemName: "checkmark")
                                                }
                                                else{
                                                    
                                                }
                                            }
                                        }
                                    }
                                } header: {
                                    Text("Categorías")
                                }
                            }
                            .listStyle(.insetGrouped)
                            NavigationLink(destination:{
                                orgView2()
                            }, label: {
                                Text("Buscar")
                            })
                            .buttonStyle(.bordered)
                            Spacer()
                                .frame(height: geo.size.height/16)
                        }
                        .frame(height: geo.size.height/1.1)
                        Color(red: 253/255, green: 247/255, blue: 173/255)
                    }
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
                    .offset(y: geo.size.height/2.15)
                    
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
