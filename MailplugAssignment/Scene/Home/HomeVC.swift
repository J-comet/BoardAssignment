//
//  HomeVC.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/16.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then


final class HomeVC: BaseViewController<HomeView, HomeViewModel> {
    
    private let leftBarButton = UIBarButtonItem(
        image: .hamburgerMenu.defaultIconStyle,
        style: .plain,
        target: nil,
        action: nil
    )
    
    private let rightBarButton = UIBarButtonItem(
        image: .magnifyingGlass.defaultIconStyle,
        style: .plain,
        target: nil,
        action: nil
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureVC()
    }
    
}

extension HomeVC {
    
    func bindViewModel() {
        leftBarButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = MenuVC(viewModel: MenuViewModel())
                vc.modalPresentationStyle = .pageSheet
                owner.present(vc, animated: true)
            }
            .disposed(by: viewModel.disposeBag)
        
        rightBarButton.rx.tap
            .bind(with: self) { owner, _ in
                print("검색 클릭")
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    func configureVC() {
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        let height = CGFloat(44)
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 44, width: view.frame.width, height: height)
        let navView = NavTitleView().then {
            $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        }
        navView.updateTitle(title: "게시판")
        navigationItem.titleView = navView
    }
}

