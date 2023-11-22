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
    case getPosts(boardID: Int, request: PostsRequest)
    case search(boardID: Int, request: SearchRequest)

    private var baseURL: URL {
        URL(string: Constant.API.baseURL)!
    }
    
    private var path: String {
        switch self {
        case .getBoards:
            return "boards"
        case .getPosts(let id, _):
            return "boards/\(id)/posts"
        case .search(let id, _):
            return "boards/\(id)/posts"
        }
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var query: [String: String]? {
        switch self {
        case .getBoards:
            return nil
        case .getPosts(_, let request):
            return request.toEncodable
        case .search(_, let request):
            return request.toEncodable
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
