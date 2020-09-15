//
//  PlainTableViewController.swift
//  ChildrenNet
//
//  Created by Zack on 2020/4/23.
//  Copyright © 2020 ZK. All rights reserved.
//

import UIKit

/// tableView
class PlainTableViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(tableView, belowSubview: navView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navView.snp.bottom)
            make.left.right.equalTo(0)
            make.bottom.equalTo(self.view)
        }
    }
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.tableFooterView = UIView()
        tb.backgroundColor = UIColor.kColorf6
        tb.showsHorizontalScrollIndicator = false
        tb.showsVerticalScrollIndicator = false
        tb.separatorStyle = .none
        tb.keyboardDismissMode = .onDrag
        tb.delegate = self
        tb.dataSource = self
        tb.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier)
        return tb
    }()
    
    /// 能否继续刷新
    var isCanLoad: Bool = false
    var page: Int = 1
    
    /// 数组个数
    var lists = [Any]()
    
    
}

// UI
extension PlainTableViewController {
    
    /// 请求数据, 数据够20个，且可以上拉的时候也会调动
    @objc func loadDatas() {
        
    }
}



// MARK: - UITableViewDelegate
extension PlainTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == lists.count - 4 && self.isCanLoad {
            page += 1
            loadDatas()
        }
    }
}

// MARK: - UITableViewDataSource
extension PlainTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellIdentifier, for: indexPath)
        cell.contentView.backgroundColor = UIColor.random
        return cell
    }
}

