//
//  SearchKeywordResultsListCollectionViewCell.swift
//  Recipe
//
//  Created by apple on 2020/9/18.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class SearchKeywordResultsListCollectionViewCell: CollectionViewCell {
    var model: HomeImageModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
            introductionLabel.text = model.introduction
            iconImageView.image = UIImage(named: model.image)
            seeBtn.setTitle(String(model.seeNumber), for: .normal)
            starBtn.setTitle(String(model.starNumber), for: .normal)
        }
    }
    override func configUI() {
        setCornerRadius(radius: 5)
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: self.frame.height, height: self.frame.height))
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalTo(-10)
        }
        
        contentView.addSubview(introductionLabel)
        introductionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalTo(-10)
        }
        
        contentView.addSubview(seeBtn)
        seeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(introductionLabel.snp.bottom).offset(20)
            make.left.equalTo(iconImageView.snp.right).offset(10)
        }
        
        
        contentView.addSubview(starBtn)
        starBtn.snp.makeConstraints { (make) in
            make.top.equalTo(introductionLabel.snp.bottom).offset(20)
            make.left.equalTo(seeBtn.snp.right)
        }
        
    }
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 16.mediumFont, color: UIColor.kColor333, alignment: .left)
        return lb
    }()
    
    lazy var introductionLabel: UILabel = {
        let lb = UILabel(font: 12.mediumFont, color: UIColor.kColor333, alignment: .left)
        return lb
    }()
    
    lazy var iconImageView: UIImageView = {//创建ImageView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        return imageView
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
