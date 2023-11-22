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
    
    enum SearchTarget: String {
        case all
        case title
        case contents
        case writer
    }
}
