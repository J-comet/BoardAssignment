//
//  NavTitleLabel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import UIKit

import SnapKit
import Then

final class NavTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.8, height: 44))
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        font = .monospacedSystemFont(ofSize: 20, weight: .semibold)
        textColor = .mpSecondaryBlackChocolate700
        textAlignment = .left
    }
}
