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
    
    init(localBoardRepository: LocalBoardRepository) {
        self.localBoardRepository = localBoardRepository
    }
    
    let boardMenuTitle = BehaviorRelay(value: "")
    
    func getBoardTitle() {
        guard let items = localBoardRepository.fetch() else {
            boardMenuTitle.accept("")
            return
        }

        if items.isEmpty {
            boardMenuTitle.accept("")
        } else {
            boardMenuTitle.accept(items.toArray().first?.displayName ?? "")
        }
    }
}
