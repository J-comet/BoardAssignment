//
//  NavTitleView.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import UIKit

import SnapKit
import Then

final class NavTitleView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.font = .monospacedSystemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .mpSecondaryBlackChocolate700
        $0.textAlignment = .left
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func updateTitle(title: String) {
        titleLabel.text = title
    }
}
