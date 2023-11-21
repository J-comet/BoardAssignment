//
//  RemotePostRepository.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/21.
//

import Foundation

import RxSwift

final class RemotePostRepository {
    
    func getPosts(boardID: Int, offset: Int) -> Single<Result<PostsEntity, Error>> {
        return Single.create { single in
            Network.shared.request(
                api: .getPosts(
                    boardID: boardID,
                    request: PostsRequest(offset: offset, limit: 30)
                ),
                type: PostsResponse.self) { result in
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
