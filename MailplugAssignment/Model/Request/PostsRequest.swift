//
//  PostsRequest.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/21.
//

import Foundation

struct PostsRequest: Encodable {
    let offset: Int
    let limit: Int
}
