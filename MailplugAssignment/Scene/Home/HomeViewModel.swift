//
//  HomeViewModel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/16.
//

import Foundation

import RxSwift
import RxCocoa

final class HomeViewModel: BaseViewModel {
        
    private var localBoardRepository: LocalBoardRepository
    private var remotePostRepository: RemotePostRepository
    
    init(
        localBoardRepository: LocalBoardRepository,
        remotePostRepository: RemotePostRepository
    ) {
        self.localBoardRepository = localBoardRepository
        self.remotePostRepository = remotePostRepository
    }
    
    var boardID = 0
    
    let boardMenu = BehaviorRelay(value: BoardsEntityValue())
    
    private var posts: [PostsEntityValue] = []
    var offset = 0
    private var total = 0
    
    var isContinue = false  // 페이징 가능 여부 체크
    var isPaging = false    // 페이징 중인지 체크
    let boardPosts = BehaviorRelay(value: [PostsEntityValue]())
    let isLoading = PublishRelay<Bool>()
    
    
    func getCurrentBoard() {
        guard let items = localBoardRepository.fetch() else {
            boardMenu.accept(BoardsEntityValue())
            return
        }

        if items.isEmpty {
            boardMenu.accept(BoardsEntityValue())
        } else {
            let item = items.toArray().first ?? BoardsEntityValue(boardID: 0, displayName: "")
            boardMenu.accept(item)
            boardID = item.boardID
            getPosts()
        }
    }
    
    func getPosts() {
        if offset == 0 {
            boardPosts.accept([])
        }
        isLoading.accept(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.remotePostRepository.getPosts(boardID: self.boardID, offset: self.offset)
                .subscribe(with: self) { owner, result in
                    switch result {
                    case .success(let data):
                        if owner.offset == 0 {
                            owner.total = data.total
                            owner.posts.removeAll()
                        }

                        print("결과결과")
                        
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
