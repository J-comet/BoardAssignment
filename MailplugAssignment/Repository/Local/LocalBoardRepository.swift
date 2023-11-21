//
//  LocalBoardRepository.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/21.
//

import Foundation

import RealmSwift

final class LocalBoardRepository: RealmProtocol {
    
    private let realm = try? Realm()
    
    func fetch() -> Results<BoardsEntityValue>? {
        return realm?.objects(BoardsEntityValue.self)
    }
    
    func fetchFilter(_ isIncluded: ((Query<BoardsEntityValue>) -> Query<Bool>)) -> Results<BoardsEntityValue>? {
        return realm?.objects(BoardsEntityValue.self).where { isIncluded($0) }
    }
    
    func objectByPrimaryKey<KeyType>(primaryKey: KeyType) -> BoardsEntityValue? {
        return realm?.object(ofType: BoardsEntityValue.self, forPrimaryKey: primaryKey)
    }
    
    func create(_ item: BoardsEntityValue, errorHandler: () -> Void) {
        do {
            try realm?.write {
                realm?.add(item)
            }
        } catch {
            errorHandler()
        }
    }
    
    func createAll(_ items: [BoardsEntityValue], errorHandler: () -> Void) {
        do {
            try realm?.write {
                realm?.add(items)
            }
        } catch {
            errorHandler()
        }
    }
    
    func update(_ item: BoardsEntityValue, errorHandler: () -> Void) {
        do {
            try realm?.write {
                realm?.create(
                    BoardsEntityValue.self,
                    value: item,
                    update: .modified
                )
            }
        } catch {
            errorHandler()
        }
    }
    
    func delete(_ item: BoardsEntityValue, errorHandler: () -> Void) {
        do {
            try realm?.write {
                realm?.delete(item)
            }
        } catch  {
            errorHandler()
        }
    }
}
