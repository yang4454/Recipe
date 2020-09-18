//
//  SearchKeywordCell.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/9/1.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit

class SearchKeywordCell: CollectionViewCell {

    override func configUI() {
        addSubview(bcView)
        bcView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(inset: 0))
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14))
        }
    }
    
    lazy var bcView: UIImageView = {
        let bc = UIImageView()
        bc.image =  "search_bc_cell".image?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), resizingMode: .stretch)
        return bc
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 14.font, color: Configs.Color.black, alignment: .center)
        return lb
    }()

}
