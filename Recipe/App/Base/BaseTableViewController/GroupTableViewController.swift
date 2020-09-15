//
//  GroupTableViewController.swift
//  ChildrenNet
//
//  Created by Zack on 2020/4/23.
//  Copyright © 2020 ZK. All rights reserved.
//

import UIKit

class GroupTableViewController: ViewController {
    
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
        let tb = UITableView(frame: CGRect.zero, style: .grouped)
        tb.tableFooterView = UIView()
        tb.backgroundColor = UIColor.kColorf6
        tb.showsHorizontalScrollIndicator = false
        tb.separatorStyle = .none
        tb.keyboardDismissMode = .onDrag
        tb.delegate = self
        tb.dataSource = self
        tb.emptyDataSetSource = self
        tb.emptyDataSetDelegate = self
        tb.tableHeaderView = UIView()
        tb.tableFooterView = UIView()
        tb.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier)
        return tb
    }()
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension GroupTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellIdentifier, for: indexPath) as UITableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

