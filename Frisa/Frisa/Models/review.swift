//
//  review.swift
//  Frisa
//
//  Created by Alumno on 12/10/23.
//

import Foundation
import Alamofire

struct review: Identifiable{
    var assocId: String
    var id: String
    var content: String
    var username: String
    var pfp: String
    var upVotes: Int
    var downVotes: Int
    var vote: Int
    var rating: Int
}
