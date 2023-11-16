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
        $0.updateTitle(image: .emptyPost, text: "등록된 게시글이 없습니다.")
    }
    
    override func configureHierarchy() {
        addSubview(containerView)
        addSubview(emptyView)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

