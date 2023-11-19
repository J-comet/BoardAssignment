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
