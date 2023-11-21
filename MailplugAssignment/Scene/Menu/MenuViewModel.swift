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
    
    private var localBoardRepository: LocalBoardRepository
    
    init(localBoardRepository: LocalBoardRepository) {
        self.localBoardRepository = localBoardRepository
    }
    
    let boardMenus = PublishRelay<[BoardsEntityValue]>()
    
    func getBoards() {
        guard let items = localBoardRepository.fetch() else {
            boardMenus.accept([])
            return
        }

        if items.isEmpty {
            boardMenus.accept([])
        } else {
            boardMenus.accept(items.toArray())
        }
    }
    
}
