//
//  SearchView.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import UIKit

import SnapKit
import Then

final class SearchView: BaseView {
    
    let searchBar = UISearchBar().then {
        $0.showsCancelButton = true
        $0.returnKeyType = .search
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
        
    }
    
}
