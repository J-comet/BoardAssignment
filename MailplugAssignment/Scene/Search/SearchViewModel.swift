//
//  SearchViewModel.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/22.
//

import Foundation

import RealmSwift
import RxSwift
import RxCocoa

final class SearchViewModel: BaseViewModel {
    
    private var localSearchRepository: LocalSearchRepository
    
    init(
        localSearchRepository: LocalSearchRepository
    ) {
        self.localSearchRepository = localSearchRepository
    }

    // 어떤 타켓으로 전달할지 메뉴선택지 TableView 데이터
    let searchTargetMenu = PublishRelay<[SearchTargetEntity]>()
    
    // 로컬에 저장된 최신 검색 목록
    let recentSearchHistoryData = PublishRelay<[SearchTargetEntity]>()
    
    var hasRecentSearchData = false
    
    private var notificationToken: NotificationToken?
    
    deinit {
        notificationToken?.invalidate()
    }
    
    func updateSearchTargetDatas(search: String) {
        var targets: [SearchTargetEntity] = []
        SearchRequest.SearchTarget.allCases.forEach { target in
            targets.append(SearchTargetEntity(target: target, search: search))
        }
        searchTargetMenu.accept(targets)
    }
    
    private func getLocalSearchHistory() -> [SearchTargetEntity] {
        guard let localData = localSearchRepository.fetch()?.sorted(byKeyPath: "date", ascending: false) else {
            hasRecentSearchData = false
            return []
        }
        
        let datas = localData.toArray()
        print(datas)
        hasRecentSearchData = !datas.isEmpty
        return datas
    }
    
    func saveSearchKeyword(entity: SearchTargetEntity) {
        localSearchRepository.update(entity) {
            print(#function, "검색단어 업데이트 실패")
        }
    }
    
    func removeSearchKeyword(id: String) {
        guard let item = localSearchRepository.objectByPrimaryKey(primaryKey: id) else { return }
        localSearchRepository.delete(item) {
            print("\(id) 삭제 실패")
        }
    }
    
    func localSearchHistoryObserve() {
        guard let tasks = localSearchRepository.fetch() else { return }
        notificationToken = tasks.observe { [weak self] changes in
            guard let self else { return }
            switch changes {
            case .initial:
                self.recentSearchHistoryData.accept(getLocalSearchHistory())
            case .update(_, let deletions, let insertions, let modifications):
                self.recentSearchHistoryData.accept(getLocalSearchHistory())
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
