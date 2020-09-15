//
//  ShareView.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/8/29.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit

let kcontentViewHeight: CGFloat = 44 + ez.safeAreaBottomHeight + 20 + 10 + kShareCollectionHeight
let kShareCollectionHeight: CGFloat = 130

typealias ShareViewClickedHandler = ((ShareView, IndexPath) -> Void)

/// 分享视图
class ShareView: UIView {

    private var shareList: [ShareItem] = []
    
    var clickedHandler: ShareViewClickedHandler?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT))
        addSubview(contentView)
        backgroundColor = UIColor(white: 0.3, alpha: 0.6)
        contentView.dismissClosure = { [weak self] in
            self?.dismiss()
        }
        
        setupList()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lazy
    lazy var contentView: ShareContentView = {
        let iv = ShareContentView(frame: CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: kcontentViewHeight))
        return iv
    }()
    
    private func setupList() {
        let shareItem3 = ShareItem(title: "微信好友", icon: UIImage(named: "ico-wechat")!)
        let shareItem4 = ShareItem(title: "朋友圈", icon: UIImage(named: "ico-cof")!)
        let shareItem5 = ShareItem(title: "QQ好友", icon: UIImage(named: "ico-qq")!)
        let shareItem6 = ShareItem(title: "QQ空间", icon: UIImage(named: "ico-qzone")!)
        shareList.append(contentsOf: [shareItem3, shareItem4,
                                       shareItem5, shareItem6])
        contentView.shareItems = shareList
    }

    
}

extension ShareView {
    func show() {
        UIView.viewToShow().addSubview(self)
        self.isHidden = true
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.isHidden = false
            self.contentView.y = kScreenH - kcontentViewHeight
        }) { (finshed) in
            
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.contentView.y = kScreenH
        }) { (finshed) in
            UIView.animate(withDuration: 0.3, animations: {
                self.isHidden = true
            }) { (_) in
                self.removeFromSuperview()
            }
        }
    }
}


