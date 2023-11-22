//
//  RemoteSearchRepository.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import Foundation

import RxSwift

final class RemoteSearchRepository {
    
    func search(boardID: Int, target: SearchRequest.SearchTarget, search: String, offset: Int) -> Single<Result<PostsEntity, Error>> {
        return Single.create { single in
            Network.shared.request(
                api: .search(
                    boardID: boardID,
                    request: SearchRequest(
                        search: search,
                        searchTarget: target.rawValue,
                        offset: String(offset), limit: Constant.API.limit)
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
