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
    
    private let height = CGFloat(44)
    
    private lazy var navView = NavTitleView().then {
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.height)
    }
    
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
        viewModel.getCurrentBoard()
    }
    
}

extension HomeVC {
    
    func bindViewModel() {
        leftBarButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = MenuVC(viewModel: MenuViewModel(localBoardRepository: LocalBoardRepository()))
                vc.modalPresentationStyle = .pageSheet
                vc.updateNavTitleHandler = { boardEntity in
                    owner.navView.updateTitle(title: boardEntity.displayName)
                    owner.navigationItem.titleView = owner.navView
                }
                owner.present(vc, animated: true)
            }
            .disposed(by: viewModel.disposeBag)
        
        rightBarButton.rx.tap
            .bind(with: self) { owner, _ in
                print("검색 클릭")
            }
            .disposed(by: viewModel.disposeBag)
        
        viewModel.boardMenu
            .asDriver(onErrorJustReturn: BoardsEntityValue())
            .drive(with: self) { owner, board in
                owner.navView.updateTitle(title: board.displayName)                
            }
            .disposed(by: viewModel.disposeBag)
        
        viewModel.boardPosts
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.tableView.rx.items(cellIdentifier: HomePostTableCell.identifier, cellType: HomePostTableCell.self)) { (row, element, cell) in
                cell.configCell(row: element)
            }
            .disposed(by: viewModel.disposeBag)
       
        viewModel.boardPosts
            .map { $0.isEmpty }
            .bind(with: self) { owner, isEmpty in
                if isEmpty {
                    owner.mainView.hidePostTableView()
                } else {
                    owner.mainView.showPostTableView()
                }
            }
            .disposed(by: viewModel.disposeBag)
       
        viewModel.isLoading
            .bind(with: self) { owner, isLoading in
                if isLoading {
                    LoadingIndicator.show()
                } else {
                    LoadingIndicator.hide()
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        mainView.tableView
            .rx
            .setDelegate(self)
            .disposed(by: viewModel.disposeBag)
    }
    
    func configureVC() {
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 44, width: view.frame.width, height: height)
       
        navigationItem.titleView = navView
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}
