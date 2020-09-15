//
//  TableViewCell.swift
//  ChildrenNet
//
//  Created by Zack on 2020/4/24.
//  Copyright © 2020 ZK. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = UIColor.white
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
    }

}
