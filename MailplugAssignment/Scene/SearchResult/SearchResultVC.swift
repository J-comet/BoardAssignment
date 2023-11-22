//
//  SearchResultVC.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import UIKit

import RxSwift
import RxCocoa

final class SearchResultVC: BaseViewController<SearchResultView,SearchResultViewModel> {
    
    var board: BoardsEntityValue?
    var target: SearchTargetEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        bindViewModel()
    }
    
    private func bindPostTableView() {
        
        viewModel.boardPosts
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.postTableView.rx.items(cellIdentifier: HomePostTableCell.identifier, cellType: HomePostTableCell.self)) { (row, element, cell) in
                cell.configCell(row: element)
            }
            .disposed(by: viewModel.disposeBag)
        
        viewModel.boardPosts
            .map { $0.isEmpty }
            .bind(with: self) { owner, isEmpty in
                if isEmpty {
                    // 검색 결과 없는 화면
                    owner.mainView.emptyResultSearchView.isHidden = false
                    owner.mainView.postTableView.isHidden = true
                } else {
                    owner.mainView.postTableView.isHidden = false
                    owner.mainView.emptyResultSearchView.isHidden = true
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        // TODO: 페이징
//        mainView.postTableView
//            .rx
//            .didScroll
//            .bind(with: self){ owner, _ in
//                let scrollViewContentHeight = owner.mainView.tableView.contentSize.height
//                let scrollOffsetThreshold = scrollViewContentHeight - owner.mainView.tableView.bounds.height
//
//                if owner.mainView.postTableView.contentOffset.y > scrollOffsetThreshold
//                    && owner.mainView.postTableView.isDragging {
//                    if !owner.viewModel.isPaging && owner.viewModel.isContinue {
//                        owner.viewModel.getPosts()
//                        owner.viewModel.isPaging = true
//                    }
//                }
//            }
//            .disposed(by: viewModel.disposeBag)
    }
}

extension SearchResultVC {
    
    func bindViewModel() {
        
        bindPostTableView()
    }
    
    func configureVC() {
        guard let board else { return }
        viewModel.updateSearchData(boardID: board.boardID)
    }
}
