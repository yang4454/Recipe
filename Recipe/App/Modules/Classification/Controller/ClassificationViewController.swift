//
//  ClassificationViewController.swift
//  Recipe
//
//  Created by apple on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
let kClassificationImagePad: CGFloat = 2
let kClassificationImageWidth: CGFloat = (SCREEN_WIDTH - 2 * kClassificationImagePad-80) / 3
let kClassificationImageHeight: CGFloat = 50


//分类
class ClassificationViewController: ViewController {

    private var mineList = [ClassificationItem]()
    private var dishesList = [DishesListItem]()
    
    private var dishesListHeather = [DishesListItemHeather]()


    override func viewDidLoad() {
        super.viewDidLoad()
        navView.isHidden = true

        view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SCREEN_WIDTH-80))
        }
        
        view.addSubview(collectionView)
        collectionView.snp.remakeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0))
        }

        requestMineDatas()
        
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH-80, height: kClassificationImageHeight)
        layout.itemSize = CGSize(width: kClassificationImageWidth, height: kClassificationImageHeight)
        layout.minimumInteritemSpacing = kClassificationImagePad
        layout.minimumLineSpacing = kClassificationImagePad
        
        let iv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        iv.backgroundColor = UIColor.clear
        iv.showsHorizontalScrollIndicator = false
        iv.showsVerticalScrollIndicator = false
        iv.register(DishesListCollectionViewCell.self, forCellWithReuseIdentifier: DishesListCollectionViewCell.cellIdentifier)
        iv.register(DishesListCollectionViewHeatherCell.self, forCellWithReuseIdentifier: DishesListCollectionViewHeatherCell.cellIdentifier)
        iv.dataSource = self
        iv.delegate = self

        return iv
        
        
    }()
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.backgroundColor = UIColor.kColorf6
        tb.showsHorizontalScrollIndicator = false
        tb.showsVerticalScrollIndicator = false
        tb.separatorStyle = .none
        tb.keyboardDismissMode = .onDrag
        
        tb.delegate = self
        tb.dataSource = self
        tb.rowHeight = 44
        tb.register(ClassificationTableViewCell.self, forCellReuseIdentifier: ClassificationTableViewCell.cellIdentifier)
        return tb
    }()


}
extension ClassificationViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishesListCollectionViewHeatherCell.cellIdentifier, for: indexPath) as! DishesListCollectionViewHeatherCell
        cell.model = dishesListHeather[indexPath.section]
        return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}


extension ClassificationViewController {
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
// MARK: - UITableViewDelegate
extension ClassificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = mineList[indexPath.row]
        self.dishesList.append(DishesListItem(title: "猪大骨头"))
        collectionView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ClassificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mineList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassificationTableViewCell.cellIdentifier, for: indexPath) as! ClassificationTableViewCell
        cell.model = mineList[indexPath.row]
        return cell
    }
}
