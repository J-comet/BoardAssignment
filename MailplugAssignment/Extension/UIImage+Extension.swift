//
//  File.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/16.
//

import UIKit

extension UIImage {
    var naviBarItemStyle: UIImage {
        self.withTintColor(.mpSecondaryBlackChocolate700, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 18))
    }
}
