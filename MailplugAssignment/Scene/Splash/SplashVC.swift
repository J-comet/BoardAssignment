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
    
    private func appExit() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)
        }
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
                    let window = UIApplication.shared.windows[0] as UIWindow
                    let vc = HomeVC(
                        viewModel: HomeViewModel(
                            localBoardRepository: LocalBoardRepository(),
                            remotePostRepository: RemotePostRepository()
                        )
                    )
                    window.rootViewController = UINavigationController(rootViewController: vc)
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        owner.showAlert(title: "", msg: Strings.Error.forceExit, ok: Strings.Common.ok) { _ in
                            owner.appExit()
                        }
                    }
                }
            }
            .disposed(by: viewModel.disposeBag)
    }
}

