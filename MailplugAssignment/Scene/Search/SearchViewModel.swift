//
//  SearchViewModel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import Foundation

import RxSwift
import RxCocoa

final class SearchViewModel: BaseViewModel {
    
    private var remoteSearchRepository: RemoteSearchRepository
    
    init(
        remoteSearchRepository: RemoteSearchRepository
    ) {
        self.remoteSearchRepository = remoteSearchRepository
    }
    
    var boardID = 0
    var target: SearchRequest.SearchTarget = .all
    var search = ""
    var offset = 0
    private var posts: [PostsEntityValue] = []
    
    let boardPosts = BehaviorRelay(value: [PostsEntityValue]())
    let isLoading = PublishRelay<Bool>()
    
    func updateSearchData(
        boardID: Int? = nil,
        target: SearchRequest.SearchTarget? = nil,
        search: String? = nil,
        offset: Int? = nil
    ) {
        if let boardID {
            self.boardID = boardID
        }
        if let target {
            self.target = target
        }
        if let search {
            self.search = search
        }
        if let offset {
            self.offset = offset
        }
    }
    
    func searchPost() {
        if offset == 0 {
            posts.removeAll()
        }
        isLoading.accept(true)
        remoteSearchRepository.search(boardID: boardID, target: target, search: search, offset: offset)
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    
                    print(data.value)
                    
                    owner.posts.append(contentsOf: data.value)
                    owner.boardPosts.accept(owner.posts)
                    
                case .failure:
                    owner.boardPosts.accept(owner.posts)
                }
                owner.isLoading.accept(false)
            }
            .disposed(by: disposeBag)
    }
}
