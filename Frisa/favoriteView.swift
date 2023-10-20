//
//  favoriteView.swift
//  Frisa
//
//  Created by Alumno on 09/10/23.
//

import SwiftUI
import Kingfisher

struct favoriteView: View {
    
    
    @State var associations: [SavedAssoc]
    @State var AssocViewData: Association
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationStack{
            GeometryReader{geo in
                VStack{
                    HStack{
                        Spacer()
                        Text("Favoritos")
                        
                            .font(.title)
                            .task {
                                do{
                                    associations = try await getFavorites()
                                } catch {
                                    print(error)
                                }
                            }
                        Spacer()
                    }
                    VStack{
                        ScrollView(.vertical){
                            LazyVGrid(columns: layout, spacing: 20) {
                                ForEach(0..<associations.count, id: \.self) { index in
                                    
                                    let logoUrl = associations[index].logoURL 
                                    let completeUrl = apiURL + logoUrl
                                    let assocViewData: Association = Association(_id: associations[index].id, name: associations[index].name, description: associations[index].description, ownerId: "", colaborators: [], logoURL: associations[index].logoURL, images: [], websiteURL: "", facebookURL: "", instagramURL: "", categoryId: "", tags: [], contact: Contact(email: "", phone: "", whatsapp: ""), address: "", verified: false)
                                    Text("")
                                        .task{
                                            do{
                                                AssocViewData = assocViewData
                                            }
                                        }
                                    
                                    
                                    NavigationLink{
                                        orgView2(association: $AssocViewData)
                                    } label: {
                                        KFImage(URL(string: completeUrl)!)
                                            .resizable()
                                            .padding()
                                            .frame(width: 150, height: 100)
                                            .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                                    }
                                }
                            }
                        }
                        menuBarView()
                            .frame(height: geo.size.height*1/13)
                    }
                }
            }
        }
    }
}

#Preview {
    favoriteView(associations: [], AssocViewData: Association(_id: "", name: "", description: "", ownerId: "", colaborators: [], logoURL: "", images: [], websiteURL: "", facebookURL: "", instagramURL: "", categoryId: "", tags: [], contact: Contact(email: "", phone: "", whatsapp: ""), address: "", verified: false))
}
