//
//  HomeVC.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/16.
//

import UIKit

import SnapKit
import Then

final class HomeVC: BaseViewController<HomeView, HomeViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureVC()
    }
    
    @objc func searchButtonClicked() {
        print("111")
    }
    
    func bindViewModel() {
        
    }
    
    func configureVC() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .hamburgerMenu.naviBarItemStyle,
            style: .plain,
            target: self,
            action: #selector(searchButtonClicked)
        )
  
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .magnifyingGlass.naviBarItemStyle,
            style: .plain,
            target: self,
            action: #selector(searchButtonClicked)
        )
        
        let height = CGFloat(44)
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 44, width: view.frame.width, height: height)
        let navView = NavTitleView().then {
            $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        }
        navView.updateTitle(title: "게시판")
        navigationItem.titleView = navView
    }
}

