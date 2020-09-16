//
//  DishesListCollectionViewCell.swift
//  Recipe
//
//  Created by apple on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
class DishesListItem {
    var title: String = ""
    
    init(title: String) {
        self.title = title
    }
}
class DishesListCollectionViewCell: CollectionViewCell {
    var model: DishesListItem? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
        }
    }
    
    override func configUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.size.equalTo(CGSize(width: (SCREEN_WIDTH - 2 * kClassificationImagePad-80) / 3, height: 50))
        }
        
    }
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 14.mediumFont, color: UIColor.kColor333, alignment: .center)
        return lb
    }()
    
}
