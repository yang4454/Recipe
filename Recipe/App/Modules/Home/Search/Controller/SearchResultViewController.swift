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
        collectionView.reloadData()
        startRefresh()
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
        
        layout.itemSize = CGSize(width: kHomeImageWidth, height: kHomeImageHeight)
        layout.minimumInteritemSpacing = kHomeImagePad
        layout.minimumLineSpacing = kHomeImagePad
        layout.sectionInset = UIEdgeInsets(top: kHomeImagePad, left: kHomeImagePad, bottom: 0, right: kHomeImagePad)
        
        let iv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        iv.backgroundColor = UIColor.clear
        iv.showsHorizontalScrollIndicator = false
        iv.showsVerticalScrollIndicator = false
        iv.register(HomeImageItemCell.self, forCellWithReuseIdentifier: HomeImageItemCell.cellIdentifier)
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

 MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeImageItemCell.cellIdentifier, for: indexPath) as! HomeImageItemCell
        let model = lists[indexPath.item]
        cell.imageView.kf.setImage(with: URL(string: model.thumbnail), placeholder: Configs.Images.cellPlaceholder)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let browser = PhotoBrowser()
        browser.data(list: lists, pageIndex: indexPath.item)
        let dict = ["from": "SEARCH", "keyword": self.key]
        browser.slider(page: page, dict: dict)
        browser.show()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == lists.count - 4 && self.isCanLoad {
            page += 1
            loadDatas()
        }
    }

}
