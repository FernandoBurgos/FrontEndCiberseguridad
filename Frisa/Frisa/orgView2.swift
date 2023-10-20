//
//  OrgView.swift
//  Frisa
//
//  Created by Alumno on 19/09/23.
//

import SwiftUI
import Kingfisher

struct orgView2: View {
    @State var images = ["Arena", "icon"] // imagenes del carrusel
    @State private var ratingOrg: Int = 0 // default
    @State private var busqueda: String = ""
    @State var posted: Bool = false
    @State var fav: Bool = false
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
                HStack{
                    Spacer()
                    Text(association.name)
                    Spacer()
                    Button{
                        if fav {
                            Task {
                                do {
                                    let saved = try await unsaveAssoc(id: association._id)
                                    print(saved)
                                } catch{
                                    print(error)
                                }
                            }
                            fav.toggle()
                        } else {
                            Task {
                                do {
                                    let saved = try await saveAssoc(id: association._id)
                                    print(saved)
                                } catch{
                                    print(error)
                                }
                            }
                            fav.toggle()
                        }
                    } label: {
                        let image = (fav ? "heart.fill" : "heart")
                        Image(systemName: image)
                    }
                }
                .font(.largeTitle)
                .offset(y: -geo.size.height/2.2)
                .foregroundStyle(.black)
                Text("")
                    .task {
                        images = []
                        
                        for imageUrl in association.images{
                            let newUrl = apiURL + imageUrl
                            images.append(newUrl)
                        }
                        
                        print(association._id)
                        
                    do {
                        fetchedReviews = try await reviewModel.fetchReviews(assocID: association._id)
                        print(fetchedReviews)
                    } catch {
                        print(error)
                    }
                }
                VStack{
                    ImageOrgCarouselView(images: images)
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
                                .foregroundStyle(.black)
                            ratingView(rating: $ratingOrg).offset(x:-124).offset(y:-12)
                            HStack{
                                Image(systemName: "person")
                                TextField("Agrega un comentario", text: $busqueda)
                                    .padding(.horizontal)
                                    .foregroundStyle(.black)
                                    .frame(height: 25)
                                
                                Button(action: {
//                                    print(ratingOrg)
                                    Task{
                                        do {
                                            posted = try await reviewModel.postReview(assocId: association._id, content: busqueda, rating: ratingOrg, isPrivate: false)
                                            print(posted)
                                            busqueda = ""
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

struct ImageOrgCarouselView: View {
    let images: [String]
    @State private var currentPage = 0
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(images.indices, id: \.self) { index in
                KFImage(URL(string: images[index])!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 390, height: 200)
                    .clipped()
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .onReceive(timer) { _ in
            withAnimation {
                if currentPage < images.count - 1 {
                    currentPage += 1
                } else {
                    currentPage = 0
                }
            }
        }
    }
}



#Preview {
    orgView2(association: .constant(Association(_id: "", name: "hola", description: "descripcion", ownerId: "", colaborators: [], logoURL: "", images: [], websiteURL: "", facebookURL: "", instagramURL: "", categoryId: "", tags: [], contact: Contact(email: "", phone: "", whatsapp: ""), address: "", verified: false)))
}
