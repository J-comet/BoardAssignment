//
//  SearchRequest.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import Foundation

struct SearchRequest: Encodable {
    let search: String
    let searchTarget: String
    let offset: String
    let limit: String
    
    enum SearchTarget: String, CaseIterable {
        case all
        case title
        case contents
        case writer
        
        var category: String {
            switch self {
            case .all:
                "전체"
            case .title:
                "제목"
            case .contents:
                "내용"
            case .writer:
                "작성자"
            }
        }
    }
}
