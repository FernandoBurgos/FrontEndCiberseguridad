//
//  LoginResponse.swift
//  Frisa
//
//  Created by Alumno on 19/09/23.
//

import Foundation

struct LoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
