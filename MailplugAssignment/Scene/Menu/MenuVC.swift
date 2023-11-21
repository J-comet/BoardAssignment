//
//  MenuVC.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import UIKit

import RxSwift
import RxCocoa

final class MenuVC: BaseViewController<MenuView, MenuViewModel> {
    
    var updateNavTitleHandler: ((BoardsEntityValue) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureVC()
    }

}

extension MenuVC {
    
    func bindViewModel() {
        
        // TODO: 현재 MenuVC 에서 통신 후 게시판 메뉴들을 보여주고 있는데 개선 필요
        /**
         1. SplashVC 에서 게시판 데이터 Realm 에 저장해놓고 사용하기
         2. HomeVC 에서 getBoards 미리 호출
         3. 처음 앱 실행시 통신 성공한 첫번째 메뉴가 보일 수 있도록 하기
         4. 왼쪽 상단 메뉴 버튼 눌렀을 때 String Array 전달
         */
        viewModel.getBoards()
        
        mainView.closeButton
            .rx
            .tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: viewModel.disposeBag)
        
        viewModel.boardMenus
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.tableView.rx.items(cellIdentifier: MenuTableCell.identifier, cellType: MenuTableCell.self)) { (row, element, cell) in
                cell.configCell(row: element)
            }
            .disposed(by: viewModel.disposeBag)
        
        mainView.tableView
            .rx
            .setDelegate(self)
            .disposed(by: viewModel.disposeBag)
        
        Observable.zip(mainView.tableView.rx.itemSelected, mainView.tableView.rx.modelSelected(BoardsEntityValue.self))
            .map { $0.1 }
            .bind(with: self) { owner, value in
                owner.updateNavTitleHandler?(value)
                owner.dismiss(animated: true)
            }
            .disposed(by: viewModel.disposeBag)
        
    }
    
    func configureVC() { }
}

extension MenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
