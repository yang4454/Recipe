//
//  HomeGoodDishesListCollectionViewCell.swift
//  Recipe
//
//  Created by apple on 2020/9/17.
//  Copyright © 2020 apple. All rights reserved.
//精品好菜

import UIKit

struct HomeGoodDishesListItem {
    var title: String = ""
    var seeNumber: String = ""
    var starNumber: String = ""
    var imageName: String = ""
    var isStar : Bool = false
    
    
    
    init(title: String ,imageName: String, seeNumber: String , starNumber: String, isStar: Bool) {
        self.title = title
        self.imageName = imageName
        self.seeNumber = seeNumber
        self.starNumber = starNumber
        self.isStar = isStar
        
    }
    
}
class HomeGoodDishesListCollectionViewCell: CollectionViewCell {
    var model: HomeGoodDishesListItem? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
            
            
            seeBtn.setTitle(model.seeNumber, for: .normal)
            
            starBtn.setTitle(model.starNumber, for: .normal)
            if model.isStar {
                starBtn.setImage(UIImage(named: "home_Star"), for: .normal)
            }
            else{
                starBtn.setImage(UIImage(named: "home_UnStar"), for: .normal)
            }
            
            
            //设置ImageView显示的图片
            iconImageView.image = UIImage(named: model.imageName)
            
        }
    }
    
    override func configUI() {
        contentView.setCornerRadius(radius: 10)
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.size.equalTo(CGSize(width: kHomeImageWidth, height: kHomeImageHeight))
        }


        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.size.equalTo(CGSize(width: kHomeImageWidth, height: 50))
            make.bottom.equalTo(0)
        }

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentBackgroundView.snp.top).offset(3)
            make.left.equalTo(10)
        }
        
        contentView.addSubview(seeBtn)
        seeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(10)
        }
        
        
        contentView.addSubview(starBtn)
        starBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(seeBtn.snp.right)
        }

        
        
        
        
    }
    
    
    
    lazy var iconImageView: UIImageView = {//创建ImageView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        return imageView
    }()
    
    
    lazy var contentBackgroundView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.white
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 14.mediumFont, color: UIColor.kColor333, alignment: .left)
        return lb
    }()
    
    lazy var seeBtn: UIButton = {
        let bc = UIButton(title: "0", font: 14.mediumFont, fontColor: UIColor.kColor333, imageName: "home_see", backColor: nil, target: self, action: #selector(self.seeBtnClick))
        
        return bc
    }()
    
    
    @objc func seeBtnClick() {
        
    }
    
    
    lazy var starBtn: UIButton = {

        let bc = UIButton(title: "0", font: 14.mediumFont, fontColor: UIColor.kColor333, imageName: "home_UnStar", backColor: nil, target: self, action: #selector(self.starBtnClick))
        return bc
    }()
    
    @objc func starBtnClick() {
        
    }
    
    
    
    
}
