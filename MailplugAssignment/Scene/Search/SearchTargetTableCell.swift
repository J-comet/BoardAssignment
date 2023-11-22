//
//  SearchTargetTableCell.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import UIKit

import SnapKit
import Then

final class SearchTargetTableCell: BaseTableViewCell<SearchTargetEntity> {
    
    private let contentStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
    }
    
    private let contentLabel = SansNeoFontLabel().then {
        $0.font(weight: .regular, size: 14)
        $0.textColor = .mpNeutralCoolGrey600
    }
    
    private let searchLabel = SansNeoFontLabel().then {
        $0.font(weight: .regular, size: 16)
        $0.textColor = .mpSecondaryBlackChocolate700
    }
    
    private let arrowImage = UIImageView().then {
        $0.image = .caretArrow
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .mpNeutralCoolGrey200
    }
    
    override func configCell(row: SearchTargetEntity) {
        contentLabel.text = row.target.category + " : "
        searchLabel.text = row.search
    }
    
    override func configureHierarchy() {
        backgroundColor = .mpBackground
        selectionStyle = .none
        addSubview(contentStackView)
        addSubview(arrowImage)
        addSubview(lineView)
        
        contentLabel.setContentHuggingPriority(.required, for: .horizontal)
        arrowImage.setContentHuggingPriority(.required, for: .horizontal)
        contentStackView.addArrangedSubview(contentLabel)
        contentStackView.addArrangedSubview(searchLabel)
    }
    
    override func configureLayout() {
        contentStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalTo(arrowImage.snp.leading)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.trailing.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
