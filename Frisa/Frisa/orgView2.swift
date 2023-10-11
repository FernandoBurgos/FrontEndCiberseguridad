//
//  OrgView.swift
//  Frisa
//
//  Created by Alumno on 19/09/23.
//

import SwiftUI

struct orgView2: View {
    let images = ["Arena", "icon"] // imagenes del carrusel
    @State private var ratingOrg: Int = 0 // default
    @State private var busqueda: String = ""
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color(red: 253/255, green: 247/255, blue: 173/255)
                Text("Arena")
                    .font(.largeTitle)
                    .offset(y: -geo.size.height/2.2)
                VStack{
                    ImageCarouselView(images: images)
                        .frame(height: 150)//250?
                    ScrollView(.horizontal){
                        HStack{
                            Text("Tag1")
                                .frame(width: 100)
                                .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke(style: StrokeStyle()))
                            Text("Tag2")
                                .frame(width: 100)
                                .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke(style: StrokeStyle()))
                            Text("Tag3")
                                .frame(width: 100)
                                .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke(style: StrokeStyle()))
                            Text("Tag4")
                                .frame(width: 100)
                                .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke(style: StrokeStyle()))
                            Text("Tag5")
                                .frame(width: 100)
                                .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke(style: StrokeStyle()))
                        }
                    }
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
                        .padding(.bottom, 0)
                    ScrollView(.vertical) {
                        VStack {
                            Text("Opinión").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).offset(y:-7)
                            ratingView(rating: $ratingOrg).offset(x:-124).offset(y:-12)
                            HStack{
                                Image(systemName: "person")
                                TextField("Agrega un comentario", text: $busqueda)
                                    .padding(.horizontal)
                                    .frame(height: 25)
                                
                                Button(action: {
                                    print("Se tocó el post")
                                }) {
                                    Text("Post")
                                        .padding(.horizontal)
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 1))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            //SECCION COMMENTS
                            CommentView(starRating:4)
                            CommentView(starRating:4)
                            CommentView(starRating:4)
                        }
                    }
                    .frame(height:200)
                    //Spacer()
                      //  .frame(height: geo.size.height/30).padding(.top)
                    Divider()
                        .overlay(.black)
                        .padding(.bottom, -20) // texto
                    Text("Unidad Country \nAntonio Caso 600, Valle del Contry, Guadalupe, Nuevo León, C.P. 67174\n(+52) 81 8348 8000 \ninformes@autismoarena.org.mx")
                    Spacer()
                    HStack {
                        //mover los icons
                        Button {
                            print("funciona")
                        } label: {
                            Image("FaceIcon").resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                            
                        }
                        Button {
                            print("si funciona")
                        } label: {
                            Image("instaIcon").resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                        }
                    }
                    .offset(x: -130)
                    Spacer()
                    
                    menuBarView()
                        .offset(y: 50)
                    
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
