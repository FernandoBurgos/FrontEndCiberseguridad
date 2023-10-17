//
//  resultsView.swift
//  Frisa
//
//  Created by Alumno on 09/10/23.
//

import SwiftUI

struct resultsView: View {
    var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble"]
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var associations: [Association]
//    @State var presentOrg: Bool = false
    var body: some View {
        NavigationStack{
            GeometryReader{geo in
                VStack{
//                    NavigationView{
                    ScrollView(.vertical){
                            LazyVGrid(columns: layout, spacing: 20) {
                                ForEach(0..<associations.count) { index in
                                    NavigationLink{
                                        orgView2()
                                    } label: {
                                        Image(associations[index].logoURL!)
                                            .resizable()
                                            .padding()
                                            .frame(width: 150, height: 100)
                                            .background(Color(red: 253/255, green: 247/255, blue: 173/255))
                                            .cornerRadius(15)
                                            .tint(Color.black)
                                    }
                                }
                            }
                        }
//                    }
                    .navigationTitle("Resultados")
                    .frame(height: geo.size.height*12/13)
                    menuBarView()
                }
//                .navigationBarBackButtonHidden(true)
//                .sheet(isPresented: $presentOrg, content: {
//                    Frisa.orgView2()
//                })
            }
        }
    }
}

#Preview {
    resultsView(associations: [])
}
