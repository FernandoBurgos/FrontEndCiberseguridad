//
//  TokenResponse.swift
//  Frisa
//
//  Created by Alumno on 21/09/23.
//

import Foundation

struct TokenResponse: Decodable {
    let newAccessToken: String
    let refreshToken: String
}
