//
//  UICollectionViewCell+Extensions.swift
//  DrivingTour
//
//  Created by Zack on 2019/7/20.
//  Copyright © 2019 Zack. All rights reserved.
//

import Foundation
import UIKit


extension UICollectionViewCell {
    func addLine(height: CGFloat = 1, color: UIColor = kCellLineColor, pading: CGFloat = 0) {
        let exten_line = UIView()
        exten_line.backgroundColor = color
        contentView.addSubview(exten_line)
        exten_line.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(pading)
            make.right.equalTo(-pading)
            make.height.equalTo(height)
        }
    }
    
    static var cellIdentifier: String {
        get {
            let a = NSStringFromClass(self)
            let className = a.split(separator: ".").last
            return String(className!)
        }
    }
}
