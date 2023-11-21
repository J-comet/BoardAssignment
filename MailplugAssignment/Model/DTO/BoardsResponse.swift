//
//  BoardsResponse.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/19.
//

import Foundation


struct BoardsResponse: Decodable, CreatEntityProtocol {
    let value: [BoardsResponseValue]?
    let count: Int?
    let offset: Int?
    let limit: Int?
    let total: Int?
    
    func toEntity() -> BoardsEntity {
        return BoardsEntity(
            value: value?.map { $0.toEntity() } ?? [],
            count: count ?? 0,
            offset: offset ?? 0,
            limit: limit ?? 0,
            total: total ?? 0
        )
    }
}

struct BoardsResponseValue: Decodable, CreatEntityProtocol {
    let boardID: Int?
    let displayName: String?

    enum CodingKeys: String, CodingKey {
        case boardID = "boardId"
        case displayName
    }
    
    func toEntity() -> BoardsEntityValue {
        return BoardsEntityValue(boardID: String(boardID ?? 0), displayName: displayName ?? "")
    }
}
