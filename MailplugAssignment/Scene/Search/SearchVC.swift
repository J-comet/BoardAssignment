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
        viewModel.localSearchHistoryObserve()
    }
    
    private func moveResultSearchVC(board: BoardsEntityValue, searchTargetEntity: SearchTargetEntity) {
        let vc = SearchResultVC(viewModel: SearchResultViewModel(remoteSearchRepository: RemoteSearchRepository()))
        vc.targetEntity = searchTargetEntity
        vc.boardEntity = board
        vc.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(vc, animated: false)
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
                    // Done 버튼 눌렀을 때 결과 화면으로 이동
                    guard let board = owner.board else { return }
                    let searchTargetEntity = SearchTargetEntity(target: .all, search: searchText)
                    owner.viewModel.saveSearchKeyword(entity: searchTargetEntity)
                    owner.moveResultSearchVC(board: board, searchTargetEntity: searchTargetEntity)
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        // 입력값 체크
        mainView.searchTextField
            .rx
            .text
            .orEmpty
            .asDriver()
            .distinctUntilChanged()
            .debounce(.seconds(1))
            .drive(with: self, onNext: { owner, text in
                
                if !text.isEmpty {
                    owner.mainView.targetTableView.isHidden = false
                    owner.mainView.emptyRecentSearchView.isHidden = true
                    owner.viewModel.updateSearchTargetDatas(search: text)
                } else {
                    // TODO: 최근 검색 기록 있으면 최근기록 보여주고 없으면 빈 리스트 보여주기
                    owner.mainView.emptyRecentSearchView.isHidden = false
                    owner.mainView.targetTableView.isHidden = true
                }
            })
            .disposed(by: viewModel.disposeBag)
    }
    
    private func bindTargetTableView() {
        viewModel.searchTargetMenu
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.targetTableView.rx.items(cellIdentifier: SearchTargetTableCell.identifier, cellType: SearchTargetTableCell.self)) { (row, element, cell) in
                cell.configCell(row: element)
            }
            .disposed(by: viewModel.disposeBag)
        
        Observable.zip(mainView.targetTableView.rx.itemSelected, mainView.targetTableView.rx.modelSelected(SearchTargetEntity.self))
            .map { $0.1 }
            .bind(with: self) { owner, value in
                // 타겟 아이템 눌렀을 때 결과 화면으로 이동
                guard let board = owner.board else { return }
                owner.viewModel.saveSearchKeyword(entity: value)
                owner.moveResultSearchVC(board: board, searchTargetEntity: value)
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    
}

extension SearchVC {
    
    func configureVC() {
        guard let board else { return }
        navigationItem.rightBarButtonItem = rightBarButton
        
        mainView.searchTextField.placeholder = Strings.Search.placeHolder.localized(with: [board.displayName])
        mainView.searchTextField.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.8, height: 44)
        navigationItem.titleView = mainView.searchTextField
    }
    
    func bindViewModel() {
        bindTextField()
        bindTargetTableView()
        
        rightBarButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: false)
            }
            .disposed(by: viewModel.disposeBag)
        
        viewModel.recentSearchHistoryData
            .bind(with: self) { owner, recentSearchDatas in
                print("저장된 목록 - ", recentSearchDatas)
            }
            .disposed(by: viewModel.disposeBag)
    }
}
