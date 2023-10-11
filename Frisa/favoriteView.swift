//
//  favoriteView.swift
//  Frisa
//
//  Created by Alumno on 09/10/23.
//

import SwiftUI

struct favoriteView: View {
    var body: some View {
        NavigationStack{
            GeometryReader{geo in
                VStack{
                    List{
                        Text("Favorito")
                    }
                    .listStyle(.insetGrouped)
                    .frame(height: geo.size.height*12/13)
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
                }
            }
        }
    }
}

#Preview {
    favoriteView()
}
