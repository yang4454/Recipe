//
//  SearchKeywordViewController.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/9/7.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit

/// 搜索关键字界面
class SearchKeywordViewController: ViewController {

    var searchClosure:((String) -> ())?
    
    func searchKey(key: String) {
        manager.addHistory(item: key)
        collectionView.reloadData()
    }
    
    private var manager = SearchCustom()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navView.isHidden = true
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.bottom.right.equalTo(0)
        }
        loadHotKeywords()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = AlignedCollectionViewFlowLayout()
        let itemPad: CGFloat = 10
        layout.estimatedItemSize = CGSize(width: 100, height: 32)
        layout.horizontalAlignment = .left
        layout.minimumLineSpacing = itemPad
        layout.minimumInteritemSpacing = itemPad - 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 56)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(SearchKeywordCell.self, forCellWithReuseIdentifier: SearchKeywordCell.cellIdentifier)
        cv.register(SearchKeywordReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchKeywordReusableView")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

}

extension SearchKeywordViewController {
    private func loadHotKeywords() {
        MsgListResponse.request(api: .wallpaperSearchKeyword(dict: [:])) { (responce) in
            guard let keys = responce.value?.rel else {
                return
            }
            QL1(keys)
            self.manager.addHotKyes(keys: keys)
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension SearchKeywordViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.searchLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.searchLists[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchKeywordCell.cellIdentifier, for: indexPath) as! SearchKeywordCell
        cell.titleLabel.text = manager.searchLists[indexPath.section][indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = manager.searchLists[indexPath.section][indexPath.item]
        searchClosure?(title)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchKeywordReusableView", for: indexPath) as! SearchKeywordReusableView
            let headerTitle = manager.title(row: indexPath.section)
            header.titleLab.text = headerTitle
            header.btn.isHidden = headerTitle == "热门搜索"
            header.deleteClosure = { [weak self] in //删除
                self?.manager.removeHistory()
                self?.collectionView.reloadData()
            }
            return header
        }
        return UICollectionReusableView()
    }
    
}
