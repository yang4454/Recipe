//
//  HomeViewController.swift
//  Recipe
//
//  Created by apple on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//
let kHomeImagePad: CGFloat = 2
let kHomeImageWidth: CGFloat = (SCREEN_WIDTH - 2 * kHomeImagePad-80) / 3
let kHomeImageHeight: CGFloat = 50



import UIKit

/// 首页
class HomeViewController: ViewController {

    private var mineList = [ClassificationItem]()
    private var dishesList = [DishesListItem]()
    
    private var dishesListHeather = [DishesListItemHeather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navView.isHidden = true
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        
        
        view.addSubview(collectionView)
        collectionView.snp.remakeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0))
        }
        
        requestMineDatas()
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH-80, height: 1000)
        layout.itemSize = CGSize(width: kHomeImageWidth, height: kHomeImageHeight)
        layout.minimumInteritemSpacing = kHomeImagePad
        layout.minimumLineSpacing = kHomeImagePad
        
        let iv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        iv.backgroundColor = UIColor.clear
        iv.showsHorizontalScrollIndicator = false
        iv.showsVerticalScrollIndicator = false
        iv.register(DishesListCollectionViewCell.self, forCellWithReuseIdentifier: DishesListCollectionViewCell.cellIdentifier)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishesListCollectionViewCell.cellIdentifier, for: indexPath) as! DishesListCollectionViewCell
        cell.model = dishesList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHeaderView.cellIdentifier, for: indexPath) as! HomeHeaderView
        cell.backgroundColor = UIColor.clear
        return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}


extension HomeViewController {
    private func requestMineDatas() {
        self.mineList.append(ClassificationItem(title: "五谷杂粮"))
        self.mineList.append(ClassificationItem(title: "猪肉"))
        self.mineList.append(ClassificationItem(title: "鱼类"))
        self.mineList.append(ClassificationItem(title: "鱼类"))
        self.mineList.append(ClassificationItem(title: "鱼类"))
        
        self.dishesList.append(DishesListItem(title: "猪大骨头"))
        self.dishesList.append(DishesListItem(title: "猪大骨头"))
        self.dishesList.append(DishesListItem(title: "猪大骨头"))
        self.dishesList.append(DishesListItem(title: "猪大骨头"))
        self.dishesList.append(DishesListItem(title: "猪大骨头"))
        self.dishesList.append(DishesListItem(title: "猪大骨头"))
        self.dishesList.append(DishesListItem(title: "猪大骨头"))
        self.dishesList.append(DishesListItem(title: "猪大骨头"))
        
        
        self.dishesListHeather.append(DishesListItemHeather(title: "猪"))
        self.dishesListHeather.append(DishesListItemHeather(title: "牛"))
        self.dishesListHeather.append(DishesListItemHeather(title: "羊"))
        self.dishesListHeather.append(DishesListItemHeather(title: "羊"))
        self.dishesListHeather.append(DishesListItemHeather(title: "羊"))
        
        
    }

}
