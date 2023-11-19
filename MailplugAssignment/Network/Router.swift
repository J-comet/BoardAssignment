//
//  Router.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/19.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case getBoards

    private var baseURL: URL {
        URL(string: Constant.API.baseURL)!
    }
    
    private var path: String {
        switch self {
        case .getBoards:
            return "boards"
        }
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var query: [String: String]? {
        switch self {
        case .getBoards:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = HTTPHeaders(Constant.API.defaultHttpHeaders)
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        return request
    }
    
}
