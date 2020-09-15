//
//  ClassificationTableViewCell.swift
//  Recipe
//
//  Created by apple on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit



class ClassificationItem {
    var title: String = ""
    
    init(title: String) {
        self.title = title
    }
}

class ClassificationTableViewCell: TableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            IconView.backgroundColor = UIColor.red
        }
        else{
            IconView.backgroundColor = UIColor.white
        }
        // Configure the view for the selected state
    }
    
    var model: ClassificationItem? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.title
        }
    }

    override func configUI() {
        contentView.addSubview(IconView)
        IconView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: 5, height: self.frame.height))
            make.centerY.equalTo(contentView)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(5)
            make.size.equalTo(CGSize(width: 75, height: 44))
        }
        
    }

    
    lazy var IconView: UIView = {
        let vc = UIView()
        return vc
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 14.mediumFont, color: UIColor.kColor333, alignment: .center)
        return lb
    }()
    
}
