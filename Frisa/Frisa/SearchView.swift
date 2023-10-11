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
        NavigationStack{
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
                            NavigationLink{
                                resultsView()
                            } label: {
                                Text("Buscar")
                            }
                            .buttonStyle(.bordered)
//                            Spacer()
//                          .frame(height: geo.size.height/16)
                        }
                        .frame(height: geo.size.height*12/13)
                        menuBarView()
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    SearchView()
}
