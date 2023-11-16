//
//  SansNeoLabel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import UIKit

final class SansNeoFontLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func font(weight: SpoqaHanSansNeoFonts, size: CGFloat) {
        font = UIFont(name: weight.rawValue, size: size)
    }
}
