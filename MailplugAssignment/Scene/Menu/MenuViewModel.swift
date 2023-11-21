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
    
    private var remoteBoardRepository: RemoteBoardRepository
    
    init(remoteBoardRepository: RemoteBoardRepository) {
        self.remoteBoardRepository = remoteBoardRepository
    }
    
    let boardMenus = PublishRelay<[BoardsEntityValue]>()
    
    func getBoards() {
        remoteBoardRepository.getBoards()
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
