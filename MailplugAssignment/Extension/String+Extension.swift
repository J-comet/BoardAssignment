//
//  String+Extension.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with arguments: [CVarArg] = []) -> String {
        return String(format: self.localized, arguments: arguments)
    }
    
    func formattedDate() -> String {
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date  = formatter.date(from: self)
        formatter.dateFormat = "YY-MM-dd"
        guard let date else { return "" }
        return formatter.string(from: date)
    }
    
}
