//
//  MenuDetailsHeaderView.swift
//  Recipe
//
//  Created by apple on 2020/9/18.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class MenuDetailsHeaderView: BaseView {

    override func configUI() {
        addSubview(DetailsImageView)
        DetailsImageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: SCREEN_WIDTH/3*2))
        }
        
        addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(10)
        }
        
        addSubview(shareBtn)
        shareBtn.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.right.equalTo(-10)
        }
        
        addSubview(starBtn)
        starBtn.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.right.equalTo(shareBtn.snp.left).offset(-5)
        }
        
        addSubview(IconView)
        IconView.snp.makeConstraints { (make) in
            make.top.equalTo(DetailsImageView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 10, height: 20))
            make.left.equalTo(0)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(IconView)
            make.left.equalTo(IconView.snp.right).offset(10)
        }
        
        
        addSubview(browseAndCollectionNumberLabel)
        browseAndCollectionNumberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
    }
    
    lazy var DetailsImageView: UIImageView = {//创建ImageView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH))
        imageView.image = UIImage(named: "mine_header_bc")
        return imageView
    }()
    
    lazy var backBtn: UIButton = {
        let bc = UIButton(bcImage: "common_back_white_icon", target: self, action: #selector(self.backBtnClick))
        return bc
    }()
    
    @objc func backBtnClick() {
        
    }
    
    
    lazy var starBtn: UIButton = {
        let bc = UIButton(bcImage: "image_detail_star", target: self, action: #selector(self.starBtnClick))
        return bc
    }()
    
    @objc func starBtnClick() {
        
    }
    
    lazy var shareBtn: UIButton = {
        let bc = UIButton(bcImage: "image_detail_share2", target: self, action: #selector(self.shareBtnClick))
        return bc
    }()
    
    @objc func shareBtnClick() {
        
    }
    
    lazy var IconView: UIView = {
        let vc = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        vc.backgroundColor = UIColor(hexString: "#FFDD00")
        return vc
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 20.mediumFont, color: UIColor.kColor333, alignment: .left)
        lb.text = "五彩鸡胸肉"
        return lb
    }()
    
    lazy var browseAndCollectionNumberLabel: UILabel = {
        let lb = UILabel(font: 12.mediumFont, color: UIColor.kColor333, alignment: .left)
        lb.text = "浏览26.5万 · 收藏8269"
        return lb
    }()
    
    

}
