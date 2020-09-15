//
//  TableViewHeaderFooterView.swift
//  ChildrenNet
//
//  Created by Zack on 2020/4/24.
//  Copyright © 2020 ZK. All rights reserved.
//

import UIKit

class TableViewHeaderFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.white
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configUI() {
        
    }
}
