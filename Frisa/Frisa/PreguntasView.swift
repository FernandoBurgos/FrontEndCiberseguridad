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
        GeometryReader{geo in
            VStack{
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
                .frame(height: geo.size.height*12/13)
                .offset(y:20)
                menuBarView()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    PreguntasView()
}
