//
//  MenuDetailsListTableViewCell.swift
//  Recipe
//
//  Created by apple on 2020/9/18.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class MenuDetailsListTableViewCell: TableViewCell {

    
    override func configUI() {
        addSubview(DetailsImageView)
//        DetailsImageView.snp.makeConstraints { (make) in
//            make.top.equalTo(0)
////            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: SCREEN_WIDTH/3*2))
////            make.width.equalTo(SCREEN_WIDTH)
////            make.height.equalTo(SCREEN_WIDTH)
//        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(DetailsImageView.bottom)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
    }
    
    lazy var DetailsImageView: UIImageView = {//创建ImageView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH))
        imageView.image = UIImage(named: "home_banner")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 22.mediumFont, color: UIColor.kColor333, alignment: .left)
        lb.text = "小白学做菜必备的烹饪助手小白学做菜必备的烹饪助手小白学做菜必备的烹饪助手小白学做菜必备的烹饪助手小白学做菜必备的烹饪助手小白学做菜必备的烹饪助手小白学做菜必备的烹饪助手小白学做菜必备的烹饪助手"
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var describeLabel: UILabel = {
        let lb = UILabel(font: 12.mediumFont, color: UIColor.kColor333, alignment: .left)
        lb.text = "小白学做菜必备的烹饪助手"
        return lb
    }()
    
    lazy var searchBtn: UIButton = {
        let bc = UIButton(bcImage: "home_search", target: self, action: #selector(self.searchBtnClick))
        return bc
    }()
    
    @objc func searchBtnClick() {
        
    }
}
