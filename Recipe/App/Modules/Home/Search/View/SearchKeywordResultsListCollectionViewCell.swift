//
//  SearchKeywordResultsListCollectionViewCell.swift
//  Recipe
//
//  Created by apple on 2020/9/18.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class SearchKeywordResultsListCollectionViewCell: CollectionViewCell {
    override func configUI() {
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(0)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(iconImageView.snp.bottom)
        }
        
    }
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 12.mediumFont, color: UIColor.kColor333, alignment: .center)
        return lb
    }()
    
    lazy var iconImageView: UIImageView = {//创建ImageView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        return imageView
    }()
}
