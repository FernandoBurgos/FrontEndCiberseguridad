//
//  PreguntasView.swift
//  Frisa
//
//  Created by Fernando Martínez on 25/09/23.
//

import SwiftUI

struct PreguntasView: View {
    let images = ["ELEMENTOS"]
    let images2 = ["AYUDA"]
    let images3 = ["ENCONTRAR"]
    @State private var showPDFViewer = false
    @State private var showPDFViewer2 = false
    @State private var showPDFViewer3 = false
    @State private var refreshView = false

    var body: some View {
        GeometryReader{geo in
            VStack{
                VStack {
                    Text("Preguntas frecuentes").padding(.bottom, 150).padding(.trailing, 50).font(.system(size: 30, weight: .bold))
                    Image(systemName: "bell").resizable()
                        .frame(width: 50, height: 50) // icono se cambiara, es deco.
                        .clipped().offset(y:-150).offset(x:130)
                    ZStack {
                        Button{
                            showPDFViewer = true
                            refreshView.toggle()
                        } label: {
                            ImageCarouselView(images: images).frame(height: 140)
                        }
                        .sheet(isPresented: $showPDFViewer){
                            PDFViewer(fileName: "sample1")
                        }
                    }
                    .offset(y:-150)
                    ZStack {
                        Button {
                            showPDFViewer2 = true
                            refreshView.toggle()
                        } label: {
                            ImageCarouselView(images: images2).frame(height: 140)
                        }
                        .sheet(isPresented: $showPDFViewer2){
                            PDFViewer(fileName: "sample2 (1)")
                        }
                    }
                    .offset(y:-100)
                    ZStack {
                        Button {
                            showPDFViewer3 = true
                            refreshView.toggle()
                        } label: {
                            ImageCarouselView(images: images3).frame(height: 140) // seguramente se cambia el height
                        }
                        .sheet(isPresented: $showPDFViewer3){
                            PDFViewer(fileName: "sample3 (1)")
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
