//
//  HomeThemeListCollectionViewCell.swift
//  Recipe
//
//  Created by apple on 2020/9/16.
//  Copyright © 2020 apple. All rights reserved.
// 主题

import UIKit
struct HomeThemeListItem {
    var title: String = ""
    var describe: String = ""
    var imageName: String = ""
    
    
    init(title: String ,imageName: String, describe: String) {
        self.title = title
        self.imageName = imageName
        self.describe = describe
    }
    
}
class HomeThemeListCollectionViewCell: CollectionViewCell {
    var model: HomeThemeListItem? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
            describeLabel.text = model.describe
            //设置ImageView显示的图片
            iconImageView.image = UIImage(named: model.imageName)
            
        }
    }
    
    override func configUI() {
        contentView.setCornerRadius(radius: 10)
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.size.equalTo(CGSize(width: 130, height: 180))
        }
        
        
        contentView.addSubview(blurView)
        blurView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.size.equalTo(CGSize(width: 130, height: 50))
            make.bottom.equalTo(0)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
//            make.size.equalTo(CGSize(width: 130, height: 20))
            make.top.equalTo(blurView.snp.top).offset(3)
            make.left.equalTo(10)
        }
        
        contentView.addSubview(describeLabel)
        describeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
//            make.size.equalTo(CGSize(width: 130, height: 20))
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(10)
        }
        contentView.addSubview(iconNextImageView)
        iconNextImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.right.equalTo(-10)
            make.top.equalTo(blurView.snp.top).offset(3)
        }
    }
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 14.mediumFont, color: UIColor.kColor333, alignment: .left)
        return lb
    }()
    
    lazy var describeLabel: UILabel = {
        let lb = UILabel(font: 14.mediumFont, color: UIColor.kColor333, alignment: .left)
        return lb
    }()
    
    lazy var iconImageView: UIImageView = {//创建ImageView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        return imageView
    }()
    
    lazy var iconNextImageView: UIImageView = {//创建ImageView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.image = UIImage(named: "home_Next")
        return imageView
    }()
    
    lazy var blurView: UIVisualEffectView = {
        //初始化一个模糊效果对象（可以制作毛玻璃效果）
        let blur = UIBlurEffect(style: .light)
        //初始化一个基于模糊效果的视觉效果视图
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = CGRect(x: 40, y: 40, width: 200, height: 200)
        return blurView
    }()
    
}
