//
//  Strings.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import Foundation

enum Strings {
    
    enum Home {
        static let emptyData = "empty_data".localized
    }
    
    enum Common {
        static let board = "common_board".localized
        static let ok = "common_ok".localized
        static let cancel = "common_cancel".localized
        static let myPost = "common_my_post".localized
        static let anonymous = "common_anonymous".localized
    }
    
    enum Badge {
        static let notice = "badge_notice".localized
        static let reply = "badge_reply".localized
    }
    
    enum Search {
        static let placeHolder = "search_placeholder".localized
        static let emptyRecentSearch = "empty_recent_search".localized
        static let emptyResultSearch = "empty_result_search".localized
        static let targetAll = "search_target_all".localized
        static let targetTitle = "search_target_title".localized
        static let targetContents = "search_target_contents".localized
        static let targetWriter = "search_target_writer".localized
    }
    
    enum Error {
        static let forceExit = "error_force_exit".localized
        static let emptySearchText = "error_search_empty".localized
    }
}
