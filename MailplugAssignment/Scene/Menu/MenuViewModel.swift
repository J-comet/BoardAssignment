//
//  MenuViewModel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import Foundation

import RxSwift
import RxCocoa

final class MenuViewModel: BaseViewModel {
    
    private var boardRepository: BoardRepository
    
    init(boardRepository: BoardRepository) {
        self.boardRepository = boardRepository
    }
    
    let boardMenus = PublishRelay<[BoardsEntityValue]>()
    
    func getBoards() {
        boardRepository.getBoards()
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let entity):
                    owner.boardMenus.accept(entity.value)
                case .failure(let failure):
                    print(failure.localizedDescription)
                    owner.boardMenus.accept([])
                }
            }
            .disposed(by: disposeBag)
    }
    
}
