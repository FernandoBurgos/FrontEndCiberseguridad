//
//  Mainp.swift
//  Frisa
//
//  Created by Fernando Martínez on 18/09/23.
//

import SwiftUI

struct MainAppView: View {
    let images = ["DHH2", "medio2", "arte (1)", "invC", "animal", "asocial", "pol", "comu", "des", "salud", "ed", "dec" ] // agregar numero que sean de fundaciones
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    Text("¡Bienvenido,\nusuario!")
                        .offset(y:-50)
                        .offset(x:-80)
                        .font(.system(size: 30, weight: .bold))
                    Button{
                    }label: {
                        Image(systemName: "bell").padding().font(.system(size:20, weight: .bold))
                            .frame(maxWidth: 39)
                            .frame(height: 38).foregroundColor(.black)
                            .offset(y:-50) // mover ingresar
                            .offset(x:68)
                    }
                    
                }
                HStack {
                    ZStack {
                        NavigationLink{
                            SearchView()
                        } label: {
                            Text("Buscador")
                                .padding()
                                .font(.system(size:20, weight: .bold))
                                .frame(maxWidth: 303)
                                .frame(height: 38)
                                .foregroundColor(.black)
                                .background(RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(red: 253/255, green: 245/255, blue: 247/255))
                                    .stroke(.black, lineWidth: 1))
                        }
                    }
                    .offset(x: -15, y: -50)
                    
                    ZStack {
                        NavigationLink{
                            SearchView()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .padding()
                                .font(.system(size:20, weight: .bold))
                                .frame(maxWidth: 39)
                                .frame(height: 38)
                                .foregroundColor(.black)
                                .background(RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(red: 253/255, green: 245/255, blue: 247/255))
                                    .stroke(.black, lineWidth: 1))
                        }
                    }
                    .offset(x: 4, y: -50) // offsets combinados
                }
                
                ImageCarouselView(images: images)
                    .frame(height: 200).offset(y:-30)
                Text("Preguntas Frecuentes:").font(.system(size: 30, weight: .bold)).offset(x:-25, y: -35)
                VStack {
                    ZStack {
                        NavigationLink(destination: PreguntasView()) {
                            Image("FAQ")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 390, height: 200)
                                .clipped()
                        }
                    }
                    .offset(y: -35)
                    
                    ZStack {
                        NavigationLink{
                            PreguntasView()
                        } label: {
                            Text("Ver más")
                                .padding()
                                .font(.system(size:20, weight: .bold))
                                .frame(maxWidth: 303)
                                .frame(height: 38)
                                .foregroundColor(Color(red: 0, green: 25/255, blue: 255/255))
                                .background(RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(red: 253/255, green: 245/255, blue: 247/255))
                                    .stroke(.black, lineWidth: 1))
                        }
                    }
                    .offset(y: -25) //ver mas
                    
                    ZStack {
                        Button(action: {
                            // accion
                        }) {
                            Text("Misión")
                                .padding()
                                .font(.system(size:8, weight: .bold))
                                .frame(maxWidth: 68)
                                .frame(height: 16)
                                .foregroundColor(Color(red: 0, green: 25/255, blue: 255/255))
                                .background(RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(red: 253/255, green: 245/255, blue: 247/255))
                                    .stroke(.black, lineWidth: 1))
                        }
                    }
                    .offset(y: -25) // mision
                    
                    menuBarView()
                    
                }
            }
            .navigationBarBackButtonHidden(true)
            .offset(y:30) //todo
        }
    }
}
    
    struct ImageCarouselView: View {
        let images: [String]
        
        var body: some View {
            TabView {
                ForEach(images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 390, height: 200)
                        .clipped()
                }
            }
            .tabViewStyle(PageTabViewStyle()) // con esto el usuario mueve imagen
        }
    }

#Preview {
    MainAppView()
}
