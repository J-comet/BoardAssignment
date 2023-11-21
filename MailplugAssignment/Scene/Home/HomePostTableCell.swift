//
//  HomePostTableCell.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/21.
//

import UIKit

import SnapKit
import Then

final class HomePostTableCell: BaseTableViewCell<PostsEntityValue> {
    
    private let titleLabel = SansNeoFontLabel().then {
        $0.font(weight: .medium, size: 16)
    }
    
    override func configCell(row: PostsEntityValue) {
        titleLabel.text = row.title
    }
    
    override func configureHierarchy() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(22)
            make.centerY.equalToSuperview()
        }
    }
}
