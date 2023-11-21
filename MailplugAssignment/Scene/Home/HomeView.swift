//
//  HomeView.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/16.
//

import UIKit

import SnapKit
import Then

final class HomeView: BaseView {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .mpNeutralCoolGrey100
    }
    
    private let emptyView = EmptyView().then {
        $0.updateTitle(image: .emptyPost, text: Strings.Home.emptyData)
        $0.isHidden = true
    }
    
    let tableView = UITableView().then {
        $0.register(HomePostTableCell.self, forCellReuseIdentifier: HomePostTableCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = false
        $0.separatorStyle = .none
        $0.rowHeight = 74
        $0.isHidden = true
    }
    
    func showPostTableView() {
        tableView.isHidden = false
        emptyView.isHidden = true        
    }
    
    func hidePostTableView() {
        emptyView.isHidden = false
        tableView.isHidden = true
    }
    
    override func configureHierarchy() {
        addSubview(containerView)
        addSubview(emptyView)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
}

