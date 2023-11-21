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
    
    private let mainStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 2
    }
    
    private let badgeLabel = BadgeLabel()
    
    private let titleLabel = SansNeoFontLabel().then {
        $0.font(weight: .medium, size: 16)
    }
    
    private let clipImage = UIImageView().then {
        $0.image = .clip
    }

    private let newView = UIImageView().then {
        $0.image = .newBadge
    }
    
    private let topStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 4
    }
    
    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
    }
    
    private let postDisplayInfoLabel = SansNeoFontLabel().then {
        $0.font(weight: .light, size: 12)
        $0.textColor = .mpNeutralCoolGrey500
    }
    
    private let eyeImage = UIImageView().then {
        $0.image = .eye
    }
    
    private let viewCntLabel = SansNeoFontLabel().then {
        $0.font(weight: .light, size: 12)
        $0.textColor = .mpNeutralCoolGrey500
    }
    
    override func configCell(row: PostsEntityValue) {
        titleLabel.text = row.title
        badgeLabel.isHidden = true
        if let postType = PostsEntityValue.PostType(rawValue: row.postType) {
            switch postType {
            case .notice, .reply:
                badgeLabel.isHidden = false
                badgeLabel.setStyle(text: postType.category, hexColor: postType.backgroundColor)
            case .normal:
                badgeLabel.isHidden = true
            }
        }
        clipImage.isHidden = !row.hasInlineImage
        newView.isHidden = !row.isNewPost
        postDisplayInfoLabel.text = row.postDisplayInfo
        viewCntLabel.text = " \(row.viewCount)"
    }
    
    override func configureHierarchy() {
        backgroundColor = .mpBackground
        selectionStyle = .none
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(bottomStackView)
        
        badgeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        clipImage.setContentCompressionResistancePriority(.required, for: .horizontal)
        newView.setContentCompressionResistancePriority(.required, for: .horizontal)        
        
        topStackView.addArrangedSubview(badgeLabel)
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(clipImage)
        topStackView.addArrangedSubview(newView)
        
        bottomStackView.addArrangedSubview(postDisplayInfoLabel)
        bottomStackView.addArrangedSubview(eyeImage)
        bottomStackView.addArrangedSubview(viewCntLabel)
        
    }
    
    override func configureLayout() {
        mainStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(14)
        }
    }
}
