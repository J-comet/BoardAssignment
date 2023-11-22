//
//  SearchView.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import UIKit

import SnapKit
import Then

/**
 1. 최초 입장시 최근 검색어 있는지 확인
 2. 최근 검색어 있으면 해당 TableView 보여주기 / 없을 때는 최근 검색어 없는 화면 보여주기
 3. 검색어 입력되었을 때 타켓선택 가능한 4개뷰 보여주기
 4. 검색누르면 검색결과화면으로 이동
 */

final class SearchView: BaseView {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .mpNeutralCoolGrey100
    }
    
    let searchTextField = SearchTextField()
    
    let emptyRecentSearchView = EmptyView().then {
        $0.updateTitle(image: .emptyRecentSearch, text: Strings.Search.emptyRecentSearch)
//        $0.isHidden = true
    }
    
    let targetTableView = UITableView().then {
        $0.register(SearchTargetTableCell.self, forCellReuseIdentifier: SearchTargetTableCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = false
        $0.separatorStyle = .none
        $0.rowHeight = 48
        $0.isHidden = true
    }
    
    let recentSearchTableView = UITableView().then {
        $0.register(RecentSearchTableCell.self, forCellReuseIdentifier: RecentSearchTableCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = false
        $0.separatorStyle = .none
        $0.rowHeight = 48
        $0.isHidden = true
    }
    
    override func configureHierarchy() {
        addSubview(containerView)
        containerView.addSubview(emptyRecentSearchView)        
        containerView.addSubview(targetTableView)
        containerView.addSubview(recentSearchTableView)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalToSuperview()
        }
        
        emptyRecentSearchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        targetTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
 
        recentSearchTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
}
