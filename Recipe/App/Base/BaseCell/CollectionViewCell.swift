//
//  CollectionViewCell.swift
//  ChildrenNet
//
//  Created by Zack on 2020/4/24.
//  Copyright © 2020 ZK. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
    }
}
