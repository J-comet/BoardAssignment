//
//  BoardsEntity.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/19.
//

import Foundation

import RealmSwift

struct BoardsEntity {
    let value: [BoardsEntityValue]
    let count: Int
    let offset: Int
    let limit: Int
    let total: Int
}

final class BoardsEntityValue: Object {
    @Persisted(primaryKey: true) var boardID: Int
    @Persisted var displayName: String
    
    convenience init(
        boardID: Int,
        displayName: String
    ) {
        self.init()
        self.boardID = boardID
        self.displayName = displayName
    }
}
