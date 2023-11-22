//
//  SearchVC.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import UIKit

import RxSwift
import RxCocoa
import Then

final class SearchVC: BaseViewController<SearchView,SearchViewModel> {
    
    var board: BoardsEntityValue?
    
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
        bindViewModel()
        configureVC()
    }
    
    private func bindTextField() {
        mainView.searchTextField
            .rx
            .controlEvent(.editingDidEndOnExit)
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(mainView.searchTextField.rx.text.orEmpty)
            .bind(with: self) { owner, searchText in
                if searchText.isEmpty {
                    owner.showAlert(title: "", msg: Strings.Error.emptySearchText, ok: Strings.Common.ok)
                    owner.mainView.searchTextField.becomeFirstResponder()
                } else {
                    // TODO: target 선택 UI 개발
                    owner.viewModel.updateSearchData(target: .all, search: searchText, offset: 0)
                    owner.viewModel.searchPost()
                }
            }
            .disposed(by: viewModel.disposeBag)
    }
}

extension SearchVC {
    
    func configureVC() {
        guard let board else { return }
        navigationItem.rightBarButtonItem = rightBarButton
        viewModel.updateSearchData(boardID: board.boardID)
        mainView.searchTextField.placeholder = Strings.Search.placeHolder.localized(with: [board.displayName])
        mainView.searchTextField.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.8, height: 44)
        navigationItem.titleView = mainView.searchTextField
    }
    
    func bindViewModel() {
        bindTextField()
        
        rightBarButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: false)
            }
            .disposed(by: viewModel.disposeBag)
    }
}
