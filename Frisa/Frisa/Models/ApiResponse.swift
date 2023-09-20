//
//  ApiResponse.swift
//  Frisa
//
//  Created by Alumno on 19/09/23.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: String
    let message: String
}
