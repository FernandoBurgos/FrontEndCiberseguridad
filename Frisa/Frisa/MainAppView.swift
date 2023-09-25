//
//  Mainp.swift
//  Frisa
//
//  Created by Fernando Martínez on 18/09/23.
//

import SwiftUI

struct MainAppView: View {
    let images = ["icon", "icon"] // agregar numero que sean de fundaciones
    var body: some View {
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
                    Button(action: {
                        // que se mueva
                    }) {
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
                    Button(action: {
                        // que se mueva
                    }) {
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
                    Button(action: {
                        // Your button action for the image button here
                    }) {
                        Image("icon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 390, height: 200)
                            .clipped()
                    }
                }
                .offset(y: -35) // Offset for the image button

                ZStack {
                    Button(action: {
                        // Your button action for "Ver más" here
                    }) {
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

                    ZStack { //menu inferior
                        Color(red: 253/255, green: 247/255, blue: 173/255)
                                .frame(height: 40)
                                .offset(y:7)
                                .offset(x: 2)
                        HStack(spacing: 120) {
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
                    .offset(y:20)
                    .offset(x:0)
                    
                }
            }
            .offset(y:30) //todo
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
