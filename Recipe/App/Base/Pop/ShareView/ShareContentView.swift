//
//  ShareContentView.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/8/29.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit


let kItemSize = CGSize(width: 72, height: 100)

/// 分享容器视图
class ShareContentView: UIView {
    
    var shareItems = [ShareItem]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var dismissClosure:(() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-(20 + ez.safeAreaBottomHeight))
            make.left.equalTo(15)
            make.size.equalTo(CGSize(width: kScreenW - 30, height: 44))
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(15)
            make.size.equalTo(CGSize(width: kScreenW - 30, height: kShareCollectionHeight))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(title: "取消", font: 18.boldFont, fontColor: UIColor.kColor333, backColor: UIColor.white, target: self, action: #selector(self.cancelBtnClick))
        btn.setCornerRadius(radius: 22)
        return btn
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = MYCollectionViewFlowLayout()
        layout.direction = .center
        
        let itemPad: CGFloat = 10
        layout.itemSize = kItemSize
        layout.minimumInteritemSpacing = itemPad
        layout.minimumLineSpacing = itemPad
        layout.sectionInset = UIEdgeInsets(top: 20, left: itemPad, bottom: 0, right: itemPad)
        
        let iv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        iv.backgroundColor = UIColor.white
        iv.showsHorizontalScrollIndicator = false
        iv.showsVerticalScrollIndicator = false
        iv.register(ShareItemCell.self, forCellWithReuseIdentifier: ShareItemCell.cellIdentifier)
        iv.dataSource = self
        iv.delegate = self
        iv.setCornerRadius(radius: 8)
        return iv
    }()
    
    @objc func cancelBtnClick() {
        dismissClosure?()
    }
}

extension ShareContentView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return shareItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShareItemCell.cellIdentifier, for: indexPath) as! ShareItemCell
        cell.shareItem = shareItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}
