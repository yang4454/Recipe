//
//  SearchModel.swift
//  ChildrenNet
//
//  Created by Zack on 2020/5/11.
//  Copyright © 2020 ZK. All rights reserved.
//

import Foundation

import HandyJSON

private let kSearchMaxKey: Int = 10

/// 自定义的模型组
class SearchCustom {
    var searchLists: [[String]] {
        if historyKeys.count == 0 && hotKyes.count == 0 {
            return [[String]]()
        }
        return historyKeys.count == 0 ? [hotKyes] : [historyKeys, hotKyes]
    }
    
    private(set) var historyKeys: [String] = SearchMamager.hasHistorySearch()
    
    private(set) var hotKyes: [String] = [String]()
    
    func title(row: Int) -> String {
        if historyKeys.count == 0 {
            return "热门搜索"
        }
        if row == 0 {
            return "历史搜索"
        }
        return "热门搜索"
    }
    
    func addHotKyes(keys: [String]) {
        hotKyes = keys
    }
    
    func addHistory(item: String) {
        historyKeys.append(item)
        historyKeys = historyKeys.unique
        if historyKeys.count > kSearchMaxKey { // 
            historyKeys = Array(historyKeys.suffix(kSearchMaxKey))
        }
        
        SearchMamager.saveHistory(keys: historyKeys)
    }
    
    /// 删除本地历史搜索
    func removeHistory() {
        historyKeys = [String]()
        SearchMamager.removeHistory()
    }
}

/// 搜索管理类
class SearchMamager {
    static let keyChildrenHistorySearch = "ChildrenHistorySearch"
    
    /// 是否有历史搜索记录
    class func hasHistorySearch() -> [String] {
        guard let keys = UserDefaults.standard.array(forKey: keyChildrenHistorySearch) as? [String] else {
            return [String]()
        }
        let tmpKeys = Array(keys.prefix(kSearchMaxKey))
        return tmpKeys
    }
    
    class func removeHistory() {
        UserDefaults.standard.removeObject(forKey: keyChildrenHistorySearch)
        UserDefaults.standard.synchronize()
    }
    
    /// 保存
    class func saveHistory(keys: [String]) {
        let tmpKeys = Array(keys.prefix(kSearchMaxKey))
        UserDefaults.standard.set(tmpKeys, forKey: keyChildrenHistorySearch)
        UserDefaults.standard.synchronize()
    }
}

