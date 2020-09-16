//
//  HomeViewHeadView.swift
//  Recipe
//
//  Created by apple on 2020/9/16.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import FSPagerView

//protocol HomeHeaderViewDelegate: NSObjectProtocol {
//
//    
//}

/// 首页头部视图
class HomeHeaderView: BaseView {

//    var delegate: HomeHeaderViewDelegate?
    
    private var lists: [String] = ["screen_1", "screen_2","screen_3"]
    
    /// 轮播
    lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: 300))
        pagerView.automaticSlidingInterval = 3
        pagerView.isInfinite = true // 无限翻页
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.transformer = FSPagerViewTransformer(type: .linear) //样式
        let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        pagerView.itemSize = pagerView.frame.size.applying(transform)
        pagerView.decelerationDistance = 1
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        return pagerView
    }()

}


extension HomeHeaderView: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return lists.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
        cell.imageView?.image = UIImage(named: lists[index])
        
//        //自定义图片
//        let vi = UIView(frame: self.view.frame)
//        vi.backgroundColor = UIColor.red
//        cell.imageView?.image = UIView.getImageFromView(view: vi)
        
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
}
