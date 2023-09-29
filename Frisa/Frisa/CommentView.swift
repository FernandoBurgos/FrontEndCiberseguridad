//
//  CommentView.swift
//  Frisa
//
//  Created by Fernando Martínez on 28/09/23.
//

import SwiftUI

struct CommentView: View {
    let starRating: Int
    @State private var liked: Bool? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .clipped()
                    .padding(.trailing, 10)
                
                Text("ARENA es la mejor ONG de la historia, e YCO también es increíble!!")
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.1)))
            }
            
            // Estrella
            HStack {
                ForEach(1..<6) { index in // loop del uno al cinco para las estrellas
                    Image(systemName: starRating >= index ? "star.fill" : "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                //like
                Button(action: {
                    liked = true
                }) {
                    Image(systemName: liked == true ? "hand.thumbsup.fill" : "hand.thumbsup") //para arriba
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(liked == true ? .blue : .gray)
                //dislike
                Button(action: {
                    liked = false
                }) {
                    Image(systemName: liked == false ? "hand.thumbsdown.fill" : "hand.thumbsdown") // hacia abajo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(liked == false ? .red : .gray)
            }
            .padding(.top, 5)
        }
    }
}


#Preview {
    CommentView(starRating: 4) // default
}
