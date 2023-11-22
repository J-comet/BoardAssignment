//
//  SearchTextField.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import UIKit

final class SearchTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var textPadding = UIEdgeInsets(
        top: 8,
        left: 12,
        bottom: 8,
        right: 12
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    private func config() {
        let image = UIImage(named: "MagnifyingGlass")!
        let iconView = UIImageView(frame: CGRect(x: 10, y: 11, width: 20, height: 20)) // set your Own size
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 44))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
  
        textColor = .mpSecondaryBlackChocolate700
        font = UIFont(name: SpoqaHanSansNeoFonts.regular.rawValue, size: 16)
        backgroundColor = .mpNeutralCoolGrey100
        clipsToBounds = true
        layer.cornerRadius = 4
        clearButtonMode = .never
        returnKeyType = .search
    }
    
    func setPlaceHolder(placeHolder: String) {
        attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.mpNeutralCoolGrey100]
        )
    }
    
}
