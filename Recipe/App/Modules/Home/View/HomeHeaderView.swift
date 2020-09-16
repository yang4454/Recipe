//
//  HomeViewHeadView.swift
//  Recipe
//
//  Created by apple on 2020/9/16.
//  Copyright © 2020 apple. All rights reserved.
//
let kHomeHeaderDishesListImagePad: CGFloat = 10
let kHomeHeaderDishesListImageWidth: CGFloat = (SCREEN_WIDTH - 40) / 5
let kHomeHeaderDishesListImageHeight: CGFloat = 80


import UIKit
import FSPagerView

//protocol HomeHeaderViewDelegate: NSObjectProtocol {
//
//    
//}

/// 首页头部视图
class HomeHeaderView: CollectionViewCell {

//    var delegate: HomeHeaderViewDelegate?
    
    private var lists: [String] = ["home_banner", "home_banner","home_banner"]
    private var dishesList = [HomeDishesListItem]()
    private var dishesThemeList = [HomeThemeListItem]()
    
    
    override func configUI() {
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(pagerView)
        contentView.addSubview(collectionViewMenu)
        collectionViewMenu.snp.makeConstraints { (make) in
            make.top.equalTo(pagerView.snp.bottom)
            make.left.equalTo(20)
            make.width.equalTo(kScreenW-40)
            make.height.equalTo(kHomeHeaderDishesListImageHeight*2+4)
        }
        contentView.addSubview(collectionViewTheme)
        collectionViewTheme.snp.makeConstraints { (make) in
            make.top.equalTo(collectionViewMenu.snp.bottom)
            make.left.equalTo(kHomeHeaderDishesListImagePad*5/2)
            make.width.equalTo(kScreenW-kHomeHeaderDishesListImagePad*5)
            make.height.equalTo(kHomeHeaderDishesListImageHeight*2+50)
        }
        
        requestMineDatas()
        
    }
    
    
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
//        pagerView.backgroundColor = UIColor.red
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        return pagerView
    }()
    
    //菜单
    lazy var collectionViewMenu: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: kHomeHeaderDishesListImageWidth, height: kHomeHeaderDishesListImageHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let iv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        iv.backgroundColor = UIColor.clear
        iv.showsHorizontalScrollIndicator = false
        iv.showsVerticalScrollIndicator = false
        iv.register(HomeDishesListCollectionViewCell.self, forCellWithReuseIdentifier: HomeDishesListCollectionViewCell.cellIdentifier)
        iv.dataSource = self
        iv.delegate = self
        return iv
    }()
    //主题
    lazy var collectionViewTheme: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 130, height: 180)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = kHomeHeaderDishesListImagePad
        layout.scrollDirection = .horizontal
        
        let iv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        iv.backgroundColor = UIColor.clear
        iv.showsHorizontalScrollIndicator = false
        iv.showsVerticalScrollIndicator = false
        iv.register(HomeThemeListCollectionViewCell.self, forCellWithReuseIdentifier: HomeThemeListCollectionViewCell.cellIdentifier)
        iv.dataSource = self
        iv.delegate = self
        return iv
    }()

}
extension HomeHeaderView {
    private func requestMineDatas() {
        
        self.dishesList.append(HomeDishesListItem(title: "家常菜", imageName: "HomeCooking"))
        self.dishesList.append(HomeDishesListItem(title: "烘焙", imageName: "home_baking"))
        self.dishesList.append(HomeDishesListItem(title: "素菜", imageName: "home_VegetarianDishes"))
        self.dishesList.append(HomeDishesListItem(title: "川菜", imageName: "home_SichuanCuisine"))
        self.dishesList.append(HomeDishesListItem(title: "面食", imageName: "home_cookedWheatenFood"))
        self.dishesList.append(HomeDishesListItem(title: "面包", imageName: "home_bread"))
        self.dishesList.append(HomeDishesListItem(title: "小吃", imageName: "home_snacks"))
        self.dishesList.append(HomeDishesListItem(title: "蛋糕", imageName: "home_cake"))
        self.dishesList.append(HomeDishesListItem(title: "西餐", imageName: "home_WesternFood"))
        self.dishesList.append(HomeDishesListItem(title: "全部", imageName: "home_AllFood"))
        
        self.dishesThemeList.append(HomeThemeListItem(title: "三餐", imageName: "home_banner", describe: "早中晚"))
        self.dishesThemeList.append(HomeThemeListItem(title: "三餐", imageName: "home_banner", describe: "早中晚"))
        self.dishesThemeList.append(HomeThemeListItem(title: "三餐", imageName: "home_banner", describe: "早中晚"))
        self.dishesThemeList.append(HomeThemeListItem(title: "三餐", imageName: "home_banner", describe: "早中晚"))
        self.dishesThemeList.append(HomeThemeListItem(title: "三餐", imageName: "home_banner", describe: "早中晚"))
        
        
        
    }

}
// MARK: - FSPagerView
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
//MARK: - CollectionView
extension HomeHeaderView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView ==  collectionViewMenu{
            return dishesList.count
        }
        else{
            return dishesThemeList.count
        }
       
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView ==  collectionViewMenu {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeDishesListCollectionViewCell.cellIdentifier, for: indexPath) as! HomeDishesListCollectionViewCell
            cell.model = dishesList[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeThemeListCollectionViewCell.cellIdentifier, for: indexPath) as! HomeThemeListCollectionViewCell
            cell.model = dishesThemeList[indexPath.row]
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}
