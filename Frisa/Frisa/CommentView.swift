//
//  CommentView.swift
//  Frisa
//
//  Created by Fernando Martínez on 28/09/23.
//

import SwiftUI

struct CommentView: View {
    let starRating: Int
    let comment: String
    let upVotes: Int
    let downVotes: Int
    let username: String
    let vote: Int
    let revID: String
    @State var localUpVotes: Int = 0
    @State var localDownVotes: Int = 0
    @State private var liked: Bool = false
    @State private var disliked: Bool = false
    @State var voted: Bool = false
    let reviewModel: ReviewModel = ReviewModel()
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("")
                .task {
                    liked = (vote == 1 ? true : false)
                    disliked = (vote == 0 ? true : false)
                    localUpVotes = upVotes
                    localDownVotes = downVotes
                }
            Text("\(username)")
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .clipped()
                    .padding(.trailing, 10)
                
                Text(comment)
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
                    liked.toggle()
                    disliked = (liked == true && disliked == true ? false : disliked)
                    localDownVotes = (disliked == true ? downVotes + 1 : downVotes)
                    if (vote == 1){
                        localUpVotes = (liked == false ? localUpVotes - 1 : localUpVotes)
                        localUpVotes = (liked == true ? localUpVotes + 1 : localUpVotes)
                    } else {
                        localUpVotes = (liked == true ? upVotes + 1 : upVotes)
                        localDownVotes = (disliked == false ? localDownVotes - 1 : localDownVotes)
                    }
                    
                    
                    Task{
                        do {
                            voted = try await reviewModel.voteReview(reviewID: revID, vote: 1)
                            print(voted)
                        } catch {
                            print(error)
                        }
                    }
                }) {
                    Text("\(localUpVotes)")
                    Image(systemName: liked ? "hand.thumbsup.fill" : "hand.thumbsup") //para arriba
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(liked ? .blue : .gray)
                //dislike
                Button(action: {
                    disliked.toggle()
                    liked = (liked == true && disliked == true ? false : liked)
                    
                    localUpVotes = (liked == true ? upVotes + 1 : upVotes)
                    if (vote == 0){
                        localDownVotes = (disliked == false ? localDownVotes - 1 : localDownVotes)
                        localDownVotes = (disliked == true ? localDownVotes + 1 : localDownVotes)
                    }else {
                        localDownVotes = (disliked == true ? downVotes + 1 : downVotes)
                        localUpVotes = (liked == false ? localUpVotes - 1 : localUpVotes)
                    }
                    Task{
                        do {
                            voted = try await reviewModel.voteReview(reviewID: revID, vote: 0)
                            print(voted)
                        } catch {
                            print(error)
                        }
                    }
                }) {
                    Text("\(localDownVotes)")
                    Image(systemName: disliked ? "hand.thumbsdown.fill" : "hand.thumbsdown") // hacia abajo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(disliked ? .red : .gray)
            }
            .padding(.top, 5)
        }
    }
}


#Preview {
    CommentView(starRating: 4, comment: "ARENA es la mejor ONG de la historia, e YCO también es increíble!!", upVotes: 1, downVotes: 1, username: "Fernando", vote: -1, revID: "") // default
}
