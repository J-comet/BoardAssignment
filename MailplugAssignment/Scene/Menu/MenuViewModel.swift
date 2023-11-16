//
//  MenuViewModel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import Foundation

import RxSwift
import RxCocoa

final class MenuViewModel: BaseViewModel {
    
    let menus = BehaviorRelay(
        value: [
            Strings.Menu.generalBoard,
            Strings.Menu.anonymousBoard,
            Strings.Menu.noticeBoard,
            Strings.Menu.freeBoard
        ]
    )
    
}
