//
//  EmptyView.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import UIKit

import SnapKit
import Then

final class EmptyView: UIView {
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 24
    }
    
    private let emptyImage = UIImageView()
    private let emptyLabel = SansNeoFontLabel().then {
        $0.textColor = .mpNeutralCoolGrey600
        $0.font(weight: .regular, size: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        addSubview(stackView)
        stackView.addArrangedSubview(emptyImage)
        stackView.addArrangedSubview(emptyLabel)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func updateTitle(image: UIImage, text: String) {
        emptyImage.image = image
        emptyLabel.text = text
    }
}
