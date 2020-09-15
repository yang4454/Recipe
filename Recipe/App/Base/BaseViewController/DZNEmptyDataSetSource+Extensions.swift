//
//  DZNEmptyDataSetSource+Extensions.swift
//  ChildrenNet
//
//  Created by Zack on 2020/4/23.
//  Copyright © 2020 ZK. All rights reserved.
//

import Foundation

// MARK: - DZNEmptyDataSetSource
extension ViewController: DZNEmptyDataSetSource {
    public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attri = NSMutableAttributedString(string: "暂无数据", font: 16.mediumFont, color: UIColor.kColor999, alignment: .center)
        return attri
    }
    
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "common_no_data")!
    }
    
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -80
    }
    
    public func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 10
    }
}


// MARK: - DZNEmptyDataSetDelegate
extension ViewController: DZNEmptyDataSetDelegate {
    
}
