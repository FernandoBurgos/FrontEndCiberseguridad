//
//  OrgView.swift
//  Frisa
//
//  Created by Alumno on 19/09/23.
//

import SwiftUI

struct orgView2: View {
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color(red: 253/255, green: 247/255, blue: 173/255)
                Text("Arena")
                    .font(.largeTitle)
                    .offset(y: -geo.size.height/2.2)
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
                .offset(y: geo.size.height/1.95)
                VStack{
                    Image("Arena")
                        .resizable()
                        .frame(height: 250)
                        Text("Tag")
                            .frame(width: 100)
                            .overlay(RoundedRectangle(cornerRadius: 30)
                                .stroke(style: /*@START_MENU_TOKEN@*/StrokeStyle()/*@END_MENU_TOKEN@*/))
                            Text("Tag")
                            .frame(width: 100)
                            .overlay(RoundedRectangle(cornerRadius: 30)
                                .stroke(style: StrokeStyle()))
                    Divider()
                        .overlay(.black)
                        .padding(.top, 10)
                    Spacer()
                        .frame(height: geo.size.height/30)
                    Text("El principal reto desde 1998 en Arena, ha sido crear un ambiente de confianza en las familias, impulsando el aprendizaje y el desarrollo de las habilidades de los niños, así como mejorar su capacidad de comunicarse con otras personas, ayudándolos así a que fortalezcan su calidad de vida.")
                        .multilineTextAlignment(.center)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    Spacer()
                        .frame(height: geo.size.height/30)
                    Divider()
                        .overlay(.black)
                        .padding(.bottom, 20)
                    Text("Unidad Country \nAntonio Caso 600, Valle del Contry, Guadalupe, Nuevo León, C.P. 67174\n(+52) 81 8348 8000 \ninformes@autismoarena.org.mx")
                    Spacer()
                    HStack {
                        //mover los icons
                        Button {
                        } label: {
                            Image("FaceIcon").resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                            
                        }
                        Button {
                        } label: {
                            Image("instaIcon").resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                        }
                    }
                    .offset(x: -130)
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: geo.size.height*3.6/4)
                .background(.white)
                .offset(y: 20)
            }
            .ignoresSafeArea()
            
        }
    }
}

#Preview {
    orgView2()
}
