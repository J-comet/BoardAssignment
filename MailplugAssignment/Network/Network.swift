//
//  Network.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/19.
//

import Foundation
import Alamofire

final class Network {
    static let shared = Network()
    private init() { }
    
    func request<T: Decodable>(
        api: Router,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            api
        ).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
