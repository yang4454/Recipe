//
//  TableCornersCell.swift
//  DrivingTour
//
//  Created by Zack on 2019/7/20.
//  Copyright © 2019 Zack. All rights reserved.
//

import UIKit

/// UITableView 设置圆角的cel，使用的时候继承这个类就好
class TableCornersCell: TableViewCell {
    enum Position {
        /// 单独一个的时候
        case solo
        
        case first
        case middle
        case last
    }
    
    var position: Position = .middle

    override func layoutSubviews() {
        super.layoutSubviews()
        setCorners()
    }
    
    func setCorners() {
        let cornerRadius: CGFloat = 4.0
        switch position {
        case .solo:
            roundCorners(corners: .allCorners, radius: cornerRadius)
            break
        case .first:
            roundCorners(corners: [.topLeft, .topRight], radius: cornerRadius)
            break
        case .last:
            roundCorners(corners: [.bottomLeft, .bottomRight], radius: cornerRadius)
            break
        default:
            noCornerMask()
            break
        }
    }

}
