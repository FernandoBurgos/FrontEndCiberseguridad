//
//  PreguntasView.swift
//  Frisa
//
//  Created by Fernando Martínez on 25/09/23.
//

import SwiftUI

struct PreguntasView: View {
    let images = ["Arena", "icon"] 
    var body: some View {
        VStack {
            Text("Preguntas frecuentes").padding(.bottom, 150).padding(.trailing, 50).font(.system(size: 30, weight: .bold))
            Image(systemName: "bell").resizable()
                .frame(width: 50, height: 50) // icono se cambiara, es deco.
                .clipped().offset(y:-150).offset(x:130)
            ZStack {
                Button(){
                } label: {
                    ImageCarouselView(images: images).frame(height: 140)
                }
            }
            .offset(y:-150)
            ZStack {
                Button {
                } label: {
                    ImageCarouselView(images: images).frame(height: 140)
                }
            }
            .offset(y:-100)
            ZStack {
                Button {
                } label: {
                    ImageCarouselView(images: images).frame(height: 140) // seguramente se cambia el height
                }
            }
            .offset(y:-50)
        }
        .offset(y:20)
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
        .offset(y:38)
    }
}

#Preview {
    PreguntasView()
}
