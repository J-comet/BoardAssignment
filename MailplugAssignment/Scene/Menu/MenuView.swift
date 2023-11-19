//
//  MenuView.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/17.
//

import UIKit

import SnapKit
import Then

final class MenuView: BaseView {
    
    let closeButton = MPButton().then {
        $0.config(image: .close, top: 10, leading: 18, bottom: 10, trailing: 9)
    }
    
    private let boardLabel = SansNeoFontLabel().then {
        $0.font(weight: .light, size: 14)
        $0.text = Strings.Test.board
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .mpNeutralCoolGrey200
    }
    
    let tableView = UITableView().then {
        $0.register(MenuTableCell.self, forCellReuseIdentifier: MenuTableCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = false
        $0.separatorStyle = .none
    }
    
    override func configureHierarchy() {
        addSubview(closeButton)
        addSubview(boardLabel)
        addSubview(lineView)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.leading.equalToSuperview()
        }
        
        boardLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(9)
            make.leading.equalToSuperview().inset(18)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(boardLabel.snp.bottom).offset(9)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
