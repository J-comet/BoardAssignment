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
                    print("검색")
                }
            }
            .disposed(by: viewModel.disposeBag)
    }
}

extension SearchVC {
    
    func configureVC() {
        navigationItem.rightBarButtonItem = rightBarButton
        guard let board else { return }
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
