//
//  SplashVC.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/21.
//

import UIKit

import RxSwift
import RxCocoa
import RealmSwift

final class SplashVC: UIViewController {
    
    private let viewModel = SplashViewModel(remoteBoardRepository: RemoteBoardRepository(), localBoardRepository: LocalBoardRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mpBackground
        
        bindViewModel()
        viewModel.getBoardMenu()
        print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    private func bindViewModel() {
        viewModel.isLoading
            .asDriver(onErrorJustReturn: true)
            .drive(with: self) { owner, isLoading in
                if isLoading {
                    LoadingIndicator.show()
                } else {
                    LoadingIndicator.hide()
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        viewModel.isSuccess
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, isSuccess in
                if isSuccess {
                    print("성공")
                } else {
                    print("실패")
                }
            }
            .disposed(by: viewModel.disposeBag)
    }
}

