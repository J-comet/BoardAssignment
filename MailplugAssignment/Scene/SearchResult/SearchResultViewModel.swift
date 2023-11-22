//
//  SearchResultViewModel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import Foundation

import RxSwift
import RxCocoa

final class SearchResultViewModel: BaseViewModel {
    
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
    private var total = 0
    
    var isContinue = false  // 페이징 가능 여부 체크
    var isPaging = false    // 페이징 중인지 체크
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.remoteSearchRepository.search(boardID: self.boardID, target: self.target, search: self.search, offset: self.offset)
                .subscribe(with: self) { owner, result in
                    switch result {
                    case .success(let data):
                        if owner.offset == 0 {
                            owner.total = data.total
                            owner.posts.removeAll()
                        }
                        
                        owner.offset += Int(Constant.API.limit)!
                        owner.posts.append(contentsOf: data.value)
                        owner.boardPosts.accept(owner.posts)
                        
                        if owner.offset >= owner.total {
                            owner.isContinue = false
                        } else {
                            owner.isContinue = true
                        }
                        owner.isPaging = false
                        
                    case .failure:
                        owner.boardPosts.accept(owner.posts)
                    }
                    owner.isLoading.accept(false)
                }
                .disposed(by: self.disposeBag)
        }
    }
}
