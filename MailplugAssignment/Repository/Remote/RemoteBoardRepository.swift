//
//  RemoteBoardRepository.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/19.
//

import Foundation

import RxSwift

final class RemoteBoardRepository {
    
    func getBoards() -> Single<Result<BoardsEntity, Error>> {
        return Single.create { single in
            Network.shared.request(api: .getBoards, type: BoardsResponse.self) { result in
                switch result {
                case .success(let success):
                    single(.success(.success(success.toEntity())))
                case .failure(let failure):
                    single(.success(.failure(failure)))
                }
            }
            return Disposables.create()
        }
    }
}

