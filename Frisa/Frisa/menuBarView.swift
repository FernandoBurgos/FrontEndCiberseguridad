//
//  menuBarView.swift
//  Frisa
//
//  Created by Alumno on 10/10/23.
//

import SwiftUI

struct menuBarView: View {
    var body: some View {
        GeometryReader{geo in
            VStack{
                Spacer()
                ZStack{
                    Color(red: 253/255, green: 247/255, blue: 173/255)
//                        .frame(height: geo.size.height/13)
                    HStack(spacing: geo.size.width/3) {
                        //mover los icons
                        Button {
                        } label: {
                            Image(systemName: "bell").resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .clipped()
                        }
                        NavigationLink{
                            MainAppView()
                        } label: {
                            Image(systemName: "house").resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .clipped()
                        }
                        NavigationLink{
                            UserView()
                        } label: {
                            Image(systemName: "person.crop.circle").resizable()
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

#Preview {
    menuBarView()
}
