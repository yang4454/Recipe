//
//  HomeDishesListCollectionViewCell.swift
//  Recipe
//
//  Created by apple on 2020/9/16.
//  Copyright © 2020 apple. All rights reserved.
//
//菜单
import UIKit
struct HomeDishesListItem {
    var title: String = ""
    var imageName: String = ""
    
    init(title: String ,imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
}
class HomeDishesListCollectionViewCell: CollectionViewCell {
    var model: HomeDishesListItem? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
            //设置ImageView显示的图片
            iconImageView.image = UIImage(named: model.imageName)
        }
    }
    
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
