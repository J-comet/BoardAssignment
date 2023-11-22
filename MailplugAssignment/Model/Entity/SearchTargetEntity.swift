//
//  SearchTargetEntity.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import Foundation

import RealmSwift

final class SearchTargetEntity: Object {
    var target: SearchRequest.SearchTarget = .all
    @Persisted(primaryKey: true) var id: String
    @Persisted var search: String
    @Persisted var date: Date
    @Persisted var targetType: String
    
    convenience init(target: SearchRequest.SearchTarget, search: String) {
        self.init()
        self.id = search + target.rawValue
        self.target = target
        self.search = search
        self.targetType = target.rawValue
        self.date = if #available(iOS 15, *) {
             .now
        } else {
            Date()
        }
        
    }
}
