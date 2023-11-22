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
    
    private lazy var navTitleLabel = NavTitleLabel()
    
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
    
//    private func showSearchBar() {
//        mainView.searchBar.frame = .init(x: 500, y: 0, width: 50, height: 44)
//        navigationItem.titleView = mainView.searchBar
//        navigationItem.setLeftBarButton(nil, animated: true)
//        navigationItem.setRightBarButton(nil, animated: true)
//        
//        UIView.animate(withDuration: 0.2, animations: {
//            self.mainView.searchBar.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.8, height: 44)
//        }, completion: { finished in
//            self.mainView.searchBar.becomeFirstResponder()
//        })
//    }
//    
//    private func hideSearchBar() {
//        mainView.searchBar.resignFirstResponder()
//        navigationItem.setLeftBarButton(leftBarButton, animated: false)
//        navigationItem.setRightBarButton(rightBarButton, animated: false)
//        navigationItem.titleView = navTitleLabel
//    }
    
    
    
    private func bindTable() {
        
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
        
        mainView.tableView
            .rx
            .didScroll
            .bind(with: self){ owner, _ in
                let scrollViewContentHeight = owner.mainView.tableView.contentSize.height
                let scrollOffsetThreshold = scrollViewContentHeight - owner.mainView.tableView.bounds.height
                
                if owner.mainView.tableView.contentOffset.y > scrollOffsetThreshold
                    && owner.mainView.tableView.isDragging {
                    if !owner.viewModel.isPaging && owner.viewModel.isContinue {
                        owner.viewModel.getPosts()
                        owner.viewModel.isPaging = true
                    }
                }
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    private func bindNav() {
        viewModel.boardMenu
            .asDriver(onErrorJustReturn: BoardsEntityValue())
            .drive(with: self) { owner, board in
                owner.navTitleLabel.text = board.displayName
            }
            .disposed(by: viewModel.disposeBag)
        
        leftBarButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = MenuVC(viewModel: MenuViewModel(localBoardRepository: LocalBoardRepository()))
                vc.modalPresentationStyle = .pageSheet
                vc.updateNavTitleHandler = { boardEntity in
                    owner.navTitleLabel.text = boardEntity.displayName
                    owner.navigationItem.titleView = owner.navTitleLabel
                    owner.viewModel.currentBoard = boardEntity
                    owner.viewModel.offset = 0
                    owner.viewModel.getPosts()
                    
                    guard let _ = owner.mainView.tableView.cellForRow(at: .init(row: 0, section: 0)) else {
                        return
                    }
                    owner.mainView.tableView.scrollToRow(at:.init(row: 0, section: 0), at: .top, animated: false)
                }
                owner.present(vc, animated: true)
            }
            .disposed(by: viewModel.disposeBag)
        
        rightBarButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = SearchVC(viewModel: SearchViewModel(remoteSearchRepository: RemoteSearchRepository()))
                vc.board = owner.viewModel.currentBoard
                vc.navigationItem.hidesBackButton = true
                owner.navigationController?.pushViewController(vc, animated: false)
            }
            .disposed(by: viewModel.disposeBag)
    }
    
}

extension HomeVC {
    
    func bindViewModel() {
        bindNav()
        bindTable()
        
        viewModel.isLoading
            .bind(with: self) { owner, isLoading in
                if isLoading {
                    LoadingIndicator.show()
                } else {
                    LoadingIndicator.hide()
                }
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    func configureVC() {
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.titleView = navTitleLabel
    }
}
