//
//  MineHeaderView.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/9/3.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit
private let kMineHeaderViewItemSize = CGSize(width: 60, height: 100)

class MineHeaderView: BaseView {

    var imageViewFrame: CGRect!
    
    var chatClosure:((Int) -> ())?
    
    private var mineList = [MineHeaderItem]()
    
    override func configUI() {
        backgroundColor = UIColor.kColorf4
        imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 230)
        addSubview(imageView)
        imageViewFrame = imageView.frame
        
        addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: frame.height - kMineHeaderViewItemSize.height - 10, width: kScreenW, height: kMineHeaderViewItemSize.height)
        collectionView.setRoundCorners(corners: [.topLeft, .topRight], with: 6)
        
        DispatchQueue.global().async {
            self.mineList.append(MineHeaderItem(title: "我的下载", icon: "mine_icon_down"))
            self.mineList.append(MineHeaderItem(title: "我的收藏", icon: "mine_icon_like"))
            self.mineList.append(MineHeaderItem(title: "浏览记录", icon: "mine_icon_history"))
//            self.mineList.append(MineHeaderItem(title: "本地图片", icon: "mine_icon_local"))
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let bc = UIImageView()
        bc.image = UIImage(named: "mine_header_bc")
        bc.clipsToBounds = true
        bc.contentMode = .scaleAspectFill
        bc.isUserInteractionEnabled = true
        return bc
    }()

    lazy var collectionView: UICollectionView = {
        let layout = MYCollectionViewFlowLayout()
        layout.direction = .center
        
        let itemPad: CGFloat = (kScreenW - kMineHeaderViewItemSize.width * 3 ) / 5 - 0.2
        layout.itemSize = kMineHeaderViewItemSize
        layout.minimumInteritemSpacing = itemPad
        layout.minimumLineSpacing = itemPad
        
        let iv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        iv.backgroundColor = UIColor.white
        iv.showsHorizontalScrollIndicator = false
        iv.showsVerticalScrollIndicator = false
        iv.register(MineHeaderItemsCell.self, forCellWithReuseIdentifier: MineHeaderItemsCell.cellIdentifier)
        iv.dataSource = self
        iv.delegate = self
        
        return iv
    }()
}

extension MineHeaderView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mineList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MineHeaderItemsCell.cellIdentifier, for: indexPath) as! MineHeaderItemsCell
        cell.item = mineList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        chatClosure?(indexPath.item)
    }
}

extension MineHeaderView {
    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        var frame = imageViewFrame!
        frame.size.height -= contentOffsetY
        frame.origin.y = contentOffsetY
        imageView.frame = frame
    }
}

/// 我的分类的cell
class MineHeaderItemsCell: CollectionViewCell {
    var item: MineHeaderItem? {
        didSet {
            guard let item = item else { return }
            titleLabel.text = item.title
            iconView.image = item.icon.image
        }
    }
    
    override func configUI() {
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.centerX.equalTo(contentView.snp.centerX)
            make.size.equalTo(45.size)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(5)
            make.left.right.equalTo(0)
            make.height.equalTo(18)
        }
    }
    
    lazy var iconView: UIImageView = {
        let bc = UIImageView()
        return bc
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 12.mediumFont, color: UIColor.kColor666, alignment: .center)
        return lb
    }()
}
