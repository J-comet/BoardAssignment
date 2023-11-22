//
//  SearchResultVC.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import UIKit

import RxSwift
import RxCocoa
import Then

final class SearchResultVC: BaseViewController<SearchResultView,SearchResultViewModel> {
    
    var boardEntity: BoardsEntityValue?
    var targetEntity: SearchTargetEntity?
    
    private let rightBarButton = UIBarButtonItem(
        title: Strings.Common.cancel,
        style: .plain,
        target: nil,
        action: nil
    ).then {
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.mpNeutralCoolGrey600], for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        bindViewModel()
        
        guard let boardEntity, let targetEntity else { return }
        viewModel.updateSearchData(boardID: boardEntity.boardID, target: targetEntity.target)
        viewModel.searchPost()
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
        
        rightBarButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: false)
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    func configureVC() {
        navigationItem.rightBarButtonItem = rightBarButton
        
        guard let boardEntity, let targetEntity else { return }
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let attributedText = NSMutableAttributedString()
        let category = NSAttributedString(string: "\(targetEntity.target.category) : ", attributes: [
            NSAttributedString.Key.font: UIFont(name: SpoqaHanSansNeoFonts.regular.rawValue, size: 14)!,
            NSAttributedString.Key.foregroundColor: UIColor.mpNeutralCoolGrey600,
            NSAttributedString.Key.paragraphStyle : paragraphStyle
        ])
        attributedText.append(category)

        let search = NSAttributedString(string: "\(targetEntity.search)", attributes: [
            NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.mpSecondaryBlackChocolate700,
            NSAttributedString.Key.paragraphStyle : paragraphStyle
        ])
        attributedText.append(search)

        mainView.searchTextField.attributedText = attributedText
        
        mainView.searchTextField.placeholder = Strings.Search.placeHolder.localized(with: [boardEntity.displayName])
        mainView.searchTextField.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.8, height: 44)
        navigationItem.titleView = mainView.searchTextField
    }
}
