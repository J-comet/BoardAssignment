//
//  BadgeLabel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/21.
//

import UIKit

final class BadgeLabel: UILabel {
    
    private let edgeInset: UIEdgeInsets = .init(top: 1, left: 8, bottom: 1, right: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        clipsToBounds = true
        layer.cornerRadius = 10
        font = UIFont(name: SpoqaHanSansNeoFonts.regular.rawValue, size: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
    }
    
    func setStyle(text: String, hexColor: String) {
        self.text = text
        self.backgroundColor = UIColor(hexCode: hexColor)
    }
}
