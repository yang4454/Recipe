//
//  SearchKeywordReusableView.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/9/7.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit

/// 搜索头部视图
class SearchKeywordReusableView: UICollectionReusableView {
    var deleteClosure:(() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(16)
            make.size.equalTo(CGSize(width: 80, height: 20))
        }
        
        addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.right.equalTo(-10)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLab: UILabel = {
        let lb = UILabel(font: 14.boldFont, color: Configs.Color.black, alignment: .left)
        lb.sizeToFit()
        return lb
    }()
    
    lazy var btn: UIButton = {
        let bc = UIButton(type: .custom)
        bc.setImage("common_delte_icon".image, for: .normal)
        bc.addTarget(self, action: #selector(self.cancelBtnClick), for: .touchUpInside)
        return bc
    }()
    
    @objc func cancelBtnClick() {
        deleteClosure?()
    }
}
