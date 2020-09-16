//
//  DishesListCollectionViewHeatherCell.swift
//  Recipe
//
//  Created by apple on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class DishesListItemHeather {
    var title: String = ""
    
    init(title: String) {
        self.title = title
    }
}
class DishesListCollectionViewHeatherCell: CollectionViewCell {
    var model: DishesListItemHeather? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
        }
    }
    
    override func configUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-80, height: 50))
//            make.left.equalTo(0)
        }
        
    }
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 14.mediumFont, color: UIColor.kColor333, alignment: .left)
        return lb
    }()
    
    class func initItemWithIdentifier(_collectionview:UICollectionView,Identifier:String , index:IndexPath) -> CollectionViewCell {
        //复用
        let cell:CollectionViewCell = _collectionview.dequeueReusableCell(withReuseIdentifier: Identifier, for: index) as! CollectionViewCell
        //设置背景颜色
       cell.backgroundColor = UIColor.orange
       return cell
            
    }
}
