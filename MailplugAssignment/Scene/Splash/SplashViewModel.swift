//
//  SplashViewModel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/21.
//

import Foundation

import RxSwift
import RxCocoa
import RealmSwift

final class SplashViewModel: BaseViewModel {
    
    private var remoteBoardRepository: RemoteBoardRepository
    private var localBoardRepository: LocalBoardRepository
    
    init(remoteBoardRepository: RemoteBoardRepository, localBoardRepository: LocalBoardRepository) {
        self.remoteBoardRepository = remoteBoardRepository
        self.localBoardRepository = localBoardRepository
    }
    
    let isLoading = PublishRelay<Bool>()
    let isSuccess = PublishRelay<Bool>()

    func getBoardMenu() {
        isLoading.accept(true)
        
        guard let localBoard = localBoardRepository.fetch() else {
            isLoading.accept(false)
            isSuccess.accept(false)
            return
        }
        
        if localBoard.isEmpty {
            requestBoardMenu()
        } else {
            isLoading.accept(false)
            isSuccess.accept(true)
        }
    }
    
    private func requestBoardMenu() {
        remoteBoardRepository.getBoards()
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    print(data.value)
                    owner.saveBoardMenu(items: data.value)
                case .failure:
                    owner.isLoading.accept(false)
                    owner.isSuccess.accept(false)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func saveBoardMenu(items: [BoardsEntityValue]) {
        localBoardRepository.createAll(items) { isComplete in
            if isComplete {
                isLoading.accept(false)
                isSuccess.accept(true)
            } else {
                isLoading.accept(false)
                isSuccess.accept(false)
            }
        }
    }
}
