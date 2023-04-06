//
//  NetworkManger.swift
//  Movie App
//
//  Created by AMN on 4/5/23.
//  Copyright © 2023 Nura. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkManger<T: Codable> {
    static func fetch(from url: String, completion: @escaping (Result<T, NetworkError> ) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            debugPrint(response)
            if response.error != nil {
                completion(.failure(.invalidResponse))
                print(response.error as Any)
                return
            }
            if let responseValue = response.value {
                completion(.success(responseValue))
                return
            }
        }
    }
}
enum NetworkError: Error{
    case invalidResponse
    case nilResponse
}
