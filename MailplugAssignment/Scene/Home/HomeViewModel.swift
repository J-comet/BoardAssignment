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
    
    let boardMenu = BehaviorRelay(value: BoardsEntityValue())
    
    private var posts: [PostsEntityValue] = []
    var offset = 0
    private var total = 0
    
    let boardPosts = BehaviorRelay(value: [PostsEntityValue]())
    
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
            getPosts(boardID: item.boardID, offset: offset)
        }
    }
    
    // TODO: 페이징처리 로직 추가 필요
    private func getPosts(boardID: Int, offset: Int) {
        remotePostRepository.getPosts(boardID: boardID, offset: offset)
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    if offset == 0 {
                        owner.total = data.total
                    }
                    owner.posts.append(contentsOf: data.value)
                    owner.boardPosts.accept(owner.posts)
                case .failure:
                    owner.boardPosts.accept(owner.posts)
                }
            }
            .disposed(by: disposeBag)
    }
}
