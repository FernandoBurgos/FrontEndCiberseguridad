//
//  AccessTokenAdapter.swift
//  Frisa
//
//  Created by Alumno on 21/09/23.
//

import Foundation
import Alamofire

class AccessTokenAdapter: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let accessToken = KeychainService.getAccessToken() {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 || response.statusCode == 403 {
            refreshToken { succeeded, newAccessToken in
                if succeeded {
                    completion(.retry)
                } else {
                    completion(.doNotRetry)
                }
            }
        } else {
            completion(.doNotRetryWithError(error))
        }
    }
    
    func refreshToken(completion: @escaping (_ succeeded: Bool, _ newAccessToken: String?) -> Void) {
        guard let currentRefreshToken = KeychainService.getRefreshToken() else {
            print("No refresh token found")
            completion(false, nil)
            return
        }
        
        let params: [String: Any] = ["refreshToken": currentRefreshToken]
        let url = apiURL + "/oauth2/refreshToken"
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseDecodable(of: TokenResponse.self) { response in
                switch response.result {
                case .success(let tokenResponse):
                    KeychainService.saveAccessToken(tokenResponse.newAccessToken)
                    KeychainService.saveRefreshToken(tokenResponse.refreshToken)
                    
                    completion(true, tokenResponse.newAccessToken)
                case .failure(let error):
                    logout()
                    print("Error refreshing token: \(error)")
                    completion(false, nil)
                }
            }
    }
}
