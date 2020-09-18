//
//  MenuDetailsViewController.swift
//  Recipe
//
//  Created by apple on 2020/9/18.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class MenuDetailsViewController: ViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navView.isHidden = true
        view.backgroundColor = UIColor(hexString: "#F6F7F9")
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) in
            make.top.equalTo(-kStatusBarHeight)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
    }
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.backgroundColor = UIColor.kColorf6
        tb.showsHorizontalScrollIndicator = false
        tb.showsVerticalScrollIndicator = false
        tb.separatorStyle = .none
        tb.keyboardDismissMode = .onDrag
        tb.delegate = self
        tb.dataSource = self
        tb.tableHeaderView = MenuDetailsHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 400))
//        tb.rowHeight = 44
        tb.register(MenuDetailsListTableViewCell.self, forCellReuseIdentifier: MenuDetailsListTableViewCell.cellIdentifier)
        return tb
    }()
    

}
// MARK: - UITableViewDelegate
extension MenuDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource
extension MenuDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuDetailsListTableViewCell.cellIdentifier, for: indexPath) as! MenuDetailsListTableViewCell
//        cell.model = mineList[indexPath.row]
        return cell
    }
    

}
