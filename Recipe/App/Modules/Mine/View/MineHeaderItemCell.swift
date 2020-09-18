//
//  MineHeaderItemCell.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/9/3.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit

class MineHeaderItem {
    var title: String = ""
    var icon: String = ""
    var desc: String = ""
    
    init(title: String, icon: String, desc: String = "") {
        self.title = title
        self.icon = icon
        self.desc = desc
    }
    
}

class MineHeaderItemCell: TableViewCell {
    var model: MineHeaderItem? {
        didSet {
            guard let model = model else { return }
            iconView.image = model.icon.image
            titleLabel.text = model.title
            descLabel.text = model.desc
        }
    }
    

    override func configUI() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(0)
        }
        
        contentBackgroundView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalTo(contentView)
        }
        
        contentBackgroundView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(60)
            make.size.equalTo(CGSize(width: 100, height: 20))
        }
        
        contentBackgroundView.addSubview(nextView)
        nextView.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize(width: 9, height: 14))
        }
        
        contentBackgroundView.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.right.equalTo(nextView.snp.left).offset(-20)
            make.centerY.equalTo(contentView)
            make.height.equalTo(20)
        }
        
        contentBackgroundView.addBottomLine(height: 0.5, color: UIColor.kColorE5, pading: 20)
    }

    lazy var contentBackgroundView: UIView = {
        let iv = UIView(frame: CGRect(x: 20, y: 0 , width: kScreenW-40, height: 56))
        iv.backgroundColor = UIColor.white
        return iv
    }()
    
    lazy var iconView: UIImageView = {
        let bc = UIImageView()
        bc.sizeToFit()
        return bc
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 16.mediumFont, color: UIColor.kColor333, alignment: .left)
        return lb
    }()
    
    lazy var descLabel: UILabel = {
        let lb = UILabel(font: 16.mediumFont, color: UIColor.kColor666, alignment: .right)
        return lb
    }()
    
    lazy var nextView: UIImageView = {
        let bc = UIImageView()
        bc.image = "common_next".image
        return bc
    }()
}
