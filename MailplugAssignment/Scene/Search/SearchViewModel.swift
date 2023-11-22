//
//  SearchViewModel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import Foundation

import RxSwift
import RxCocoa

final class SearchViewModel: BaseViewModel {

    let searchTargets = PublishRelay<[SearchTargetEntity]>()
    
    func updateSearchTargetDatas(search: String) {
        var targets: [SearchTargetEntity] = []
        SearchRequest.SearchTarget.allCases.forEach { target in
            targets.append(SearchTargetEntity(target: target, search: search))
        }
        searchTargets.accept(targets)
    }
    
    
}
