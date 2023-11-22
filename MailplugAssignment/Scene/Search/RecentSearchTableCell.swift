//
//  RecentSearchTableCell.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import UIKit

import RxSwift
import SnapKit
import Then

final class RecentSearchTableCell: BaseTableViewCell<SearchTargetEntity> {
    
    var disposeBag = DisposeBag()
    
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
    
    lazy var closeImage = UIImageView().then {
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(removeTapGesture)
        $0.contentMode = .scaleAspectFit
        let insetValue: CGFloat = 3
        $0.image = .close.withAlignmentRectInsets(UIEdgeInsets(top: insetValue, left: insetValue, bottom: insetValue, right: insetValue))
    }
    
    private let recentImage = UIImageView().then {
        $0.image = .recent
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .mpNeutralCoolGrey200
    }
    
    let removeTapGesture = UITapGestureRecognizer()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configCell(row: SearchTargetEntity) {
        let content = SearchRequest.SearchTarget(rawValue: row.targetType)?.category ?? ""
        contentLabel.text = content + " : "
        searchLabel.text = row.search
    }
    
    override func configureHierarchy() {
        backgroundColor = .mpBackground
        selectionStyle = .none
        contentView.addSubview(recentImage)
        contentView.addSubview(contentStackView)
        contentView.addSubview(closeImage)
        contentView.addSubview(lineView)
        
        contentLabel.setContentHuggingPriority(.required, for: .horizontal)
        closeImage.setContentHuggingPriority(.required, for: .horizontal)
        contentStackView.addArrangedSubview(contentLabel)
        contentStackView.addArrangedSubview(searchLabel)
    }
    
    override func configureLayout() {
        recentImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(recentImage.snp.trailing).offset(10)
            make.trailing.equalTo(closeImage.snp.leading)
        }
        
        closeImage.snp.makeConstraints { make in
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
