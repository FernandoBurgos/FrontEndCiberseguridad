//
//  SearchView.swift
//  Frisa
//
//  Created by Alumno on 19/09/23.
//

import SwiftUI

struct SearchView: View {
//    @State var items: [String] = ["Derechos Humanos", "Medio Ambiente", "Cultura y Arte", "Investigación Científica", "Bienestar Animal", "Asistencia Social", "Política y Activismo", "Desarrollo Comunitario", "Salud", "Educación", "Desarrollo Económico", "Desastres y Ayuda Humanitaria"]
    @State var items: [Cat] = []
    @State var Selections: [String] = []
    @State private var busqueda: String = ""
    @State var selection: Cat? = Cat()
    @State private var associations: [Association] = []
    
    var body: some View {
        NavigationStack{
            Text("")
                .task {
                    do{
                        items.removeAll()
                        items = try await getCategories()
                    }
                    catch{
                        print(error)
                    }
                }
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
                            .padding(.top, 20)
                            .padding(.bottom, 30)
                            Text("Buscar por nombre")
                            HStack{
                                Image(systemName: "magnifyingglass")
                                TextField("Buscar", text: $busqueda)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            Section{
                                List(items, id: \.self, selection: $selection){item in
                                    Text(item.name)
                                }
                                .listStyle(.insetGrouped)
                            } header: {
                                Text("Buscar por categorías")
                            }
                            NavigationLink{
                                Text("")
                                    .task {
                                    do {
                                        let category: Cat = selection ?? Cat()
                                        let category1 = (category == Cat() ? [] : [category.id])
//                                        print(category)
//                                        print(category1)
                                        let searchOrg = SearchOrg(queryText: busqueda, categories: category1, tags: [])
                                                           self.associations = try await search(search: searchOrg)
//                                        print(associations)
                                    } catch {
                                        print("error")
                                    }
                                }
                                resultsView(associations: $associations)
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
