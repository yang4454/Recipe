//
//  SearchViewController.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/8/28.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit

/// 搜索界面
class SearchViewController: ViewController {
    
    private var keywordsCtl = SearchKeywordViewController()
    
    private var resultCtl = SearchResultViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        addCustomControllers()
    }
    
    lazy var searchView: NavSearchView = {
        let searchView = NavSearchView(frame: CGRect.zero)
        return searchView
    }()
}

// MARK: - UI
extension SearchViewController {
    private func setupNav() {
        navView.leftNavBtn.isHidden = true
        navView.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.centerY.equalTo(navView.leftNavBtn)
            make.left.equalTo(20)
            make.right.equalTo(0)
            make.height.equalTo(32)
        }
        
        
        searchView.searchClosure = { [weak self]  keyWord in
            UIView.animate(withDuration: 0.6) {
                if keyWord.count == 0 {
                    self?.endSearch()
                } else {
                    self?.startSearch(key: keyWord)
                }
            }
        }
        // 取消
        searchView.cancelClosure = { [weak self] in
            self?.endSearch(isCancel: true)
        }
        
        navView.setBackgroundImage(image: UIImage(named: "searchNav")) 
    }
    
    /// 添加控制器
    private func addCustomControllers() {
        // 结果控制器
        addChild(resultCtl)
        view.addSubview(resultCtl.view)
        resultCtl.view.isHidden = true
        resultCtl.view.snp.makeConstraints { (make) in
            make.top.equalTo(navView.snp.bottom)
            make.left.bottom.equalTo(0)
            make.width.equalTo(SCREEN_WIDTH)
        }
        
        // 关键字控制器
        addChild(keywordsCtl)
        view.addSubview(keywordsCtl.view)
        keywordsCtl.searchClosure = { [weak self] key in
            self?.startSearch(key: key)
        }
        keywordsCtl.view.snp.makeConstraints { (make) in
            make.top.equalTo(navView.snp.bottom)
            make.left.bottom.equalTo(0)
            make.width.equalTo(SCREEN_WIDTH)
        }
    }
}

extension SearchViewController {
    private func startSearch(key: String) {
        searchView.textField.text = key
        self.resultCtl.searchList(key: key)
        self.keywordsCtl.searchKey(key: key)
        self.keywordsCtl.view.isHidden = true
        self.resultCtl.view.isHidden = false
    }
    
    /// 取消搜索
    /// - Parameter isCancel: 是否是点击的取消
    private func endSearch(isCancel: Bool = false) {
        self.view.endEditing(true)
        if !self.keywordsCtl.view.isHidden {
            if isCancel {
                popVC()
            }
            return
        }
        
        self.keywordsCtl.view.isHidden = false
        self.resultCtl.view.isHidden = true
    }
}

