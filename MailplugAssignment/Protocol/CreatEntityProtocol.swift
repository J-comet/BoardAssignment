//
//  CreatEntityProtocol.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/19.
//

import Foundation

protocol CreatEntityProtocol {
    associatedtype T
    func toEntity() -> T
}
