//
//  OrgView.swift
//  Frisa
//
//  Created by Alumno on 19/09/23.
//

import SwiftUI

struct orgView2: View {
    @State var images = ["Arena", "icon"] // imagenes del carrusel
    @State private var ratingOrg: Int = 0 // default
    @State private var busqueda: String = ""
    @State var posted: Bool = false
    @State var tagNames: [String] = []
    @State var tagsArr: [String] = []
    @State var tagObject: tagResponse = tagResponse()
    let reviewModel: ReviewModel = ReviewModel()
    @State var fetchedReviews: [review] = []
    @Binding var association: Association
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Color(red: 253/255, green: 247/255, blue: 173/255)
                Text(association.name)
                    .font(.largeTitle)
                    .offset(y: -geo.size.height/2.2)
                    .foregroundStyle(.black)
                Text("")
                    .task {
                        images = []
                        
                        ForEach(association.images, id: \.self){imageUrl in
                            let newUrl = apiURL + imageUrl
                            
                        }
                        images.append("newUrl")
                        
                    do {
                        fetchedReviews = try await reviewModel.fetchReviews(assocID: association._id)
                        print(fetchedReviews)
                    } catch {
                        print(error)
                    }
                }
                VStack{
                    ImageCarouselView(images: images)
                        .frame(height: 150)//250?
                    ScrollView(.horizontal){
                        HStack{
                                Text("")
                                    .task {
                                        do{
                                            tagsArr = try await getArrTags(ids: association.tags)
                                            print(tagsArr)
                                        }
                                        catch {
                                            print(error)
                                        }
                                    }
                            ForEach(tagsArr, id: \.self){tag in
                                Text(tag)
//                                    .frame(width: 100)
                                    .overlay(RoundedRectangle(cornerRadius: 30)
                                        .stroke(style: StrokeStyle()))
                                    .foregroundStyle(.black)
                                
                            }
                        }
                    }
                    Divider()
                        .overlay(.black)
                        .padding(.top, 10)
                    Spacer()
                        .frame(height: geo.size.height/30)
                    Text(association.description ?? "")
                        .foregroundStyle(.black)
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
//                                    print(ratingOrg)
                                    Task{
                                        do {
                                            posted = try await reviewModel.postReview(assocId: association._id, content: busqueda, rating: ratingOrg, isPrivate: false)
                                            print(posted)
                                        } catch {
                                            print(error)
                                        }
                                        do {
                                            fetchedReviews = try await reviewModel.fetchReviews(assocID: association._id)
                                            print(fetchedReviews)
                                        }
                                        catch {
                                            print(error)
                                        }
                                    }
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
                            ForEach(fetchedReviews){rev in
                                CommentView(starRating: rev.rating, comment: rev.content, upVotes: rev.upVotes, downVotes: rev.downVotes, username: rev.username, vote: rev.vote, revID: rev.id)
                            }
//                            CommentView(starRating: 2, comment: "hola", upVotes: 2, downVotes: 4, username: "hola", vote: 1, revID: "")
                        }
//                        .padding(.trailing, 30)
                    }
                    .frame(height:200)
                    //Spacer()
                      //  .frame(height: geo.size.height/30).padding(.top)
                    Divider()
                        .overlay(.black)
                        .padding(.bottom, -20) // texto
//                    Text("Unidad Country \nAntonio Caso 600, Valle del Contry, Guadalupe, Nuevo León, C.P. 67174\n(+52) 81 8348 8000 \ninformes@autismoarena.org.mx")
                    Text(association.address)
                        .foregroundStyle(.black)
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
    orgView2(association: .constant(Association(_id: "", name: "hola", description: "descripcion", ownerId: "", colaborators: [], logoURL: "", images: [], websiteURL: "", facebookURL: "", instagramURL: "", categoryId: "", tags: [], contact: Contact(email: "", phone: "", whatsapp: ""), address: "", verified: false)))
}
