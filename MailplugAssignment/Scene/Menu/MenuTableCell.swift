//
//  MenuTableCell.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import UIKit

import SnapKit
import Then

final class MenuTableCell: BaseTableViewCell<String> {
    
    private let menuLabel = SansNeoFontLabel().then {
        $0.font(weight: .regular, size: 16)
    }
    
    override func configCell(row: String) {
        menuLabel.text = row
    }
    
    override func configureHierarchy() {
        selectionStyle = .none
        contentView.addSubview(menuLabel)
    }
    
    override func configureLayout() {
        menuLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(22)
            make.centerY.equalToSuperview()
        }
    }
}
