//
//  MPButton.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import UIKit

final class MPButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(
        image: UIImage,
        top: CGFloat? = 0,
        leading: CGFloat? = 0,
        bottom: CGFloat? = 0,
        trailing: CGFloat? = 0
    ) {
        if #available (iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.contentInsets = .init(
                top: top ?? 0, leading: leading ?? 0,
                bottom: bottom ?? 0, trailing: trailing ?? 0
            )
            config.image = image
//            config.baseBackgroundColor = .lightGray
//            config.baseForegroundColor = .black
            configuration = config
        } else {
            setImage(image, for: .normal)
            contentEdgeInsets = .init(top: top ?? 0, left: leading ?? 0, bottom: bottom ?? 0, right: trailing ?? 0)
        }
    }

}
