//
//  BoardsEntity.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/19.
//

import Foundation


struct BoardsEntity {
    let value: [BoardsEntityValue]
    let count: Int
    let offset: Int
    let limit: Int
    let total: Int
}

struct BoardsEntityValue {
    let boardID: Int
    let displayName: String
}
