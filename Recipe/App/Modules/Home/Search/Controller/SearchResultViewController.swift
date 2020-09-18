//
//  SearchResultViewController.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/9/7.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit

/// 图片搜索结果页
class SearchResultViewController: ViewController {
    
    var lists = [HomeImageModel]()
    
    var isCanLoad: Bool = false
    var page: Int = 1
    
    
    private var key = ""

    /// 输入关键字，搜索
    func searchList(key: String) {
        self.key = key
        lists.removeAll()
        
        self.lists.append(HomeImageModel(title: "纸杯小蛋糕", seeNumber: 100, starNumber: 200, introduction: "鸡蛋、地精面粉、白砂糖、玉米油", image: "home_banner"))
        self.lists.append(HomeImageModel(title: "原味戚风（16寸）", seeNumber: 100, starNumber: 200, introduction: "鸡蛋（60克以上）、水或者牛奶五谷杂粮五谷杂粮五谷杂粮", image: "home_banner"))
        self.lists.append(HomeImageModel(title: "五谷杂粮", seeNumber: 100, starNumber: 200, introduction: "五谷杂粮五谷杂粮", image: "home_banner"))
        
        collectionView.reloadData()
        //startRefresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navView.isHidden = true
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.bottom.right.equalTo(0)
        }
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: SCREEN_WIDTH-40, height: 100)
        layout.minimumInteritemSpacing = kHomeImagePad
        layout.minimumLineSpacing = kHomeImagePad
        layout.sectionInset = UIEdgeInsets(top: kHomeImagePad, left: kHomeImagePad, bottom: 0, right: kHomeImagePad)
        
        let iv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        iv.backgroundColor = UIColor(hexString: "#F6F7F9")
        iv.showsHorizontalScrollIndicator = false
        iv.showsVerticalScrollIndicator = false
        iv.register(SearchKeywordResultsListCollectionViewCell.self, forCellWithReuseIdentifier: SearchKeywordResultsListCollectionViewCell.cellIdentifier)
        iv.dataSource = self
        iv.delegate = self
        iv.emptyDataSetDelegate = self
        iv.emptyDataSetSource = self
        
        return iv
    }()
}

extension SearchResultViewController {
    @objc func startRefresh() {
        page = 1
        loadDatas()
    }
    
    func loadDatas() {
        let dict = ["pageNum": self.page, "pageSize": 20, "keyword": self.key] as [String : Any]
        if page == 1 {
            view.makeToastActivity(.center)
        }
        MoyaListResponse<HomeImageModel>.request(api: .wallpaperSearch(dict: dict)) { (responce) in
            self.collectionView.mj_header?.endRefreshing()
            if self.page == 1 {
                self.view.hideToastActivity()
            }
            guard let list = responce.value?.rel else {
                return
            }
            if self.page == 1 {
                
                self.lists = list
            } else {
                self.lists += list
            }
            self.isCanLoad = list.count == 20
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchKeywordResultsListCollectionViewCell.cellIdentifier, for: indexPath) as! SearchKeywordResultsListCollectionViewCell
        cell.model = lists[indexPath.item]
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == lists.count - 4 && self.isCanLoad {
            page += 1
            loadDatas()
        }
    }

}
