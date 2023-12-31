//
//  SearchResultView.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import UIKit

import SnapKit
import Then

final class SearchResultView: BaseView {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .mpNeutralCoolGrey100
    }
    
    let searchTextField = SearchTextField().then {
        $0.isEnabled = false
    }
    
    let postTableView = UITableView().then {
        $0.register(HomePostTableCell.self, forCellReuseIdentifier: HomePostTableCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = false
        $0.separatorStyle = .none
        $0.rowHeight = 74
        $0.isHidden = true
    }
    
    let emptyResultSearchView = EmptyView().then {
        $0.updateTitle(image: .emptyResultSearch, text: Strings.Search.emptyResultSearch)
    }
    
    override func configureHierarchy() {
        addSubview(containerView)
        containerView.addSubview(emptyResultSearchView)
        containerView.addSubview(postTableView)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalToSuperview()
        }
        
        postTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        emptyResultSearchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
