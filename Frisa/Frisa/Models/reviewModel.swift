//
//  reviewModel.swift
//  Frisa
//
//  Created by Alumno on 12/10/23.
//

import Foundation
import SwiftyJSON
import Alamofire
import Observation

@Observable
class ReviewModel {
    
    var reviews = [review]()
    
    init() {
        
    }
    
    
    func fetchReviews(assocID: String) async throws -> [review] {
        reviews.removeAll()
        
        let url: String = apiURL + "/api/v1/review/fetch?id=\(assocID)"
        
        let session = Session(interceptor: AccessTokenAdapter());
        
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: .get, encoding: JSONEncoding.default)
                .responseJSON {response in
                    if let error = response.error {
                        print("Error de conexión")
                        continuation.resume(throwing: error)
                    } else {
                        let json = try! JSON(data: response.data!)
                        
                        let responseReviews = json["reviews"].arrayValue
                        
                        for rev in responseReviews{
                            let newReview = review(assocId: rev["assocId"].stringValue,
                                                   id: rev["id"].stringValue,
                                                   content: rev["content"].stringValue,
                                                   username: rev["user"]["username"].stringValue,
                                                   pfp: rev["user"]["profilePictureURL"].stringValue,
                                                   upVotes: rev["upvotes"].intValue,
                                                   downVotes: rev["downvotes"].intValue,
                                                   vote: rev["vote"].intValue,
                                                   rating: rev["rating"].intValue)
                            self.reviews.append(newReview)
                            
                        }
                        
                        continuation.resume(returning: self.reviews)
                    }
                }
        }
    }
    
    func voteReview(reviewID: String, vote: Int) async throws -> Bool{
        
        let url: String = apiURL + "/api/v1/review/vote"
        
        let session = Session(interceptor: AccessTokenAdapter());
        
        return try await withCheckedThrowingContinuation { continuation in
            
            let voteDict: [String: Any] = [
                "reviewId":reviewID,
                "vote": vote
            ]
            
            session.request(url, method: .post, parameters: voteDict, encoding: JSONEncoding.default)
                .responseJSON {response in
                    switch response.result {
                    case .success(let data):
                        print(data)
                        
                        continuation.resume(returning: true)
                        
                    case .failure(let error):
                        print(error)
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func postReview(assocId: String, content: String, rating: Int, isPrivate: Bool) async throws -> Bool {
        
        let url: String = apiURL + "/api/v1/review/post"
        
        let session = Session(interceptor: AccessTokenAdapter());
        
        return try await withCheckedThrowingContinuation{continuation in
            let reviewDict: [String: Any] = [
                "assocId": assocId,
                "content": content,
                "rating": rating,
                "isPrivate": isPrivate
            ]
            
            session.request(url, method: .post, parameters: reviewDict, encoding: JSONEncoding.default)
                .responseJSON {response in
                
                    switch response.result{
                    case .success(let data):
                        print(data)
                        
                        continuation.resume(returning: true)
                        
                    case .failure(let error):
                        print(error)
                        
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
