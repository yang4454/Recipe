//
//  HomeViewController.swift
//  Recipe
//
//  Created by apple on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//
let kHomeImagePad: CGFloat = 10
let kHomeImageWidth: CGFloat = (SCREEN_WIDTH - 40-kHomeImagePad*2) / 2
let kHomeImageHeight: CGFloat = kHomeImageWidth



import UIKit

/// 首页
class HomeViewController: ViewController {

    private var dishesList = [HomeGoodDishesListItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navView.isHidden = true
        view.backgroundColor = UIColor(hexString: "#F6F7F9")
        // Do any additional setup after loading the view.
        
        
        
        view.addSubview(collectionView)
        collectionView.snp.remakeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: -kStatusBarHeight, left: 0, bottom: 0, right: 0))
        }
        
        requestMineDatas()
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH-80, height: 900)
        layout.itemSize = CGSize(width: kHomeImageWidth, height: kHomeImageHeight)
        layout.minimumInteritemSpacing = kHomeImagePad
        layout.minimumLineSpacing = kHomeImagePad
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let iv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        iv.backgroundColor = UIColor.clear
        iv.showsHorizontalScrollIndicator = false
        iv.showsVerticalScrollIndicator = false
        iv.register(HomeGoodDishesListCollectionViewCell.self, forCellWithReuseIdentifier: HomeGoodDishesListCollectionViewCell.cellIdentifier)
        iv.register(HomeHeaderView.self, forCellWithReuseIdentifier: HomeHeaderView.cellIdentifier)
        iv.dataSource = self
        iv.delegate = self

        return iv
        
        
    }()
    

}
//MARK: - CollectionView
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return dishesList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGoodDishesListCollectionViewCell.cellIdentifier, for: indexPath) as! HomeGoodDishesListCollectionViewCell
        cell.model = dishesList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHeaderView.cellIdentifier, for: indexPath) as! HomeHeaderView
        cell.delegate = self
        cell.backgroundColor = UIColor.clear
        return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}


extension HomeViewController {
    private func requestMineDatas() {
        self.dishesList.append(HomeGoodDishesListItem(title: "柠檬咖喱炒饭", imageName: "home_banner", seeNumber: "100", starNumber: "1000", isStar: true))
        self.dishesList.append(HomeGoodDishesListItem(title: "柠檬咖喱炒饭", imageName: "home_banner", seeNumber: "100", starNumber: "1000", isStar: true))
        self.dishesList.append(HomeGoodDishesListItem(title: "柠檬咖喱炒饭", imageName: "home_banner", seeNumber: "100", starNumber: "1000", isStar: true))
        self.dishesList.append(HomeGoodDishesListItem(title: "柠檬咖喱炒饭", imageName: "home_banner", seeNumber: "100", starNumber: "1000", isStar: true))
        self.dishesList.append(HomeGoodDishesListItem(title: "柠檬咖喱炒饭", imageName: "home_banner", seeNumber: "100", starNumber: "1000", isStar: true))
        self.dishesList.append(HomeGoodDishesListItem(title: "柠檬咖喱炒饭", imageName: "home_banner", seeNumber: "100", starNumber: "1000", isStar: true))
        self.dishesList.append(HomeGoodDishesListItem(title: "柠檬咖喱炒饭", imageName: "home_banner", seeNumber: "100", starNumber: "1000", isStar: true))
        self.dishesList.append(HomeGoodDishesListItem(title: "柠檬咖喱炒饭", imageName: "home_banner", seeNumber: "100", starNumber: "1000", isStar: true))
        self.dishesList.append(HomeGoodDishesListItem(title: "柠檬咖喱炒饭", imageName: "home_banner", seeNumber: "100", starNumber: "1000", isStar: true))
        self.dishesList.append(HomeGoodDishesListItem(title: "柠檬咖喱炒饭", imageName: "home_banner", seeNumber: "100", starNumber: "1000", isStar: true))
    }

}
// MARK: - HomeHeaderViewDelegate
extension HomeViewController: HomeHeaderViewDelegate {
    func toSearchViewController(){
//        self.pushVC(SearchViewController())
        self.pushVC(MenuDetailsViewController())
    }
}
