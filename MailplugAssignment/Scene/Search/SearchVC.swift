//
//  SearchVC.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import UIKit

import RxSwift
import RxCocoa

final class SearchVC: BaseViewController<SearchView,SearchViewModel> {
    
    var board: BoardsEntityValue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureVC()
    }
    
    private func bindSearchBar() {
        mainView.searchBar
            .rx
            .cancelButtonClicked
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: false)
            }
            .disposed(by: viewModel.disposeBag)
    }
}

extension SearchVC {
    
    func configureVC() {
        print(board?.displayName)
        mainView.searchBar.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.8, height: 44)
        navigationItem.titleView = mainView.searchBar
    }
    
    func bindViewModel() {
        bindSearchBar()
    }
}
