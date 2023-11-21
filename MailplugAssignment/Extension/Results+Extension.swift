//
//  Results+Extension.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/21.
//

import Foundation
import RealmSwift

extension Results {
    
    func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}
