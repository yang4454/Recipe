//
//  ShareItemCell.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/8/29.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit

public typealias SelectionHandler = ((ShareItem) -> Void)

public class ShareItem: NSObject {
    /// 标题
    public var title: String
    /// 图片名称
    public var icon: UIImage
    /// 点击事件
    public var selectionHandler: SelectionHandler?
    
    public init(title: String, icon: UIImage, selectionHandler: SelectionHandler? = nil) {
        self.title = title
        self.icon = icon
        self.selectionHandler = selectionHandler
    }
}


class ShareItemCell: UICollectionViewCell {
    /// 按钮
     var iconButton: UIButton
     /// 文字
     var titleLable: UILabel
     
     var cellClicked: ((ShareItemCell) -> Void)?
     
     var shareItem: ShareItem! {
         didSet {
             setupInfo()
         }
     }
     
     override init(frame: CGRect) {
        
         titleLable = UILabel()
         iconButton = UIButton(type: .custom)
         super.init(frame: frame)
         
         titleLable.numberOfLines = 2
         titleLable.font = UIFont.systemFont(ofSize: 14)
         titleLable.textColor = UIColor.darkGray
         titleLable.textAlignment = .center
         contentView.addSubview(titleLable)
                 
         iconButton.addTarget(self, action: #selector(iconButtonClick), for: .touchUpInside)
         contentView.addSubview(iconButton)
     }
     
     func setupInfo() {
         titleLable.text = shareItem.title
         iconButton.setImage(shareItem.icon, for: .normal)
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         
         let contentWidth = self.frame.width
         let iconButtonSize = shareItem.icon.size
         iconButton.frame = CGRect(x: (contentWidth-iconButtonSize.width)/2,
                                   y: 0,
                                   width: iconButtonSize.width,
                                   height: iconButtonSize.height)
    
         let size = titleLable.sizeThatFits(CGSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude))
         titleLable.frame = CGRect(x: 0, y: iconButtonSize.height+8,
                                   width: contentWidth, height: ceil(size.height))
     }
     
     // MARK: Action
     @objc func iconButtonClick() {
         if let shareItem = shareItem, let selectionHandler = shareItem.selectionHandler {
             selectionHandler(shareItem)
         }
         
         if let cellClicked = cellClicked {
             cellClicked(self)
         }
     }
     
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
