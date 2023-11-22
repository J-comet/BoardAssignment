//
//  LocalSearchRepository.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import Foundation

import RealmSwift

final class LocalSearchRepository: RealmProtocol {
    
    private let realm = try? Realm()
    
    func fetch() -> Results<SearchTargetEntity>? {
        return realm?.objects(SearchTargetEntity.self)
    }
    
    func fetchFilter(_ isIncluded: ((Query<SearchTargetEntity>) -> Query<Bool>)) -> Results<SearchTargetEntity>? {
        return realm?.objects(SearchTargetEntity.self).where { isIncluded($0) }
    }
    
    func objectByPrimaryKey<KeyType>(primaryKey: KeyType) -> SearchTargetEntity? {
        return realm?.object(ofType: SearchTargetEntity.self, forPrimaryKey: primaryKey)
    }
    
    func create(_ item: SearchTargetEntity, errorHandler: () -> Void) {
        do {
            try realm?.write {
                realm?.add(item)
            }
        } catch {
            errorHandler()
        }
    }
    
    func update(_ item: SearchTargetEntity, errorHandler: () -> Void) {
        do {
            try realm?.write {
                realm?.create(
                    SearchTargetEntity.self,
                    value: item,
                    update: .modified
                )
            }
        } catch {
            errorHandler()
        }
    }
    
    func delete(_ item: SearchTargetEntity, errorHandler: () -> Void) {
        do {
            try realm?.write {
                realm?.delete(item)
            }
        } catch  {
            errorHandler()
        }
    }
}
