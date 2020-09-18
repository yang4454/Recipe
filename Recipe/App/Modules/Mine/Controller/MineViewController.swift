//
//  MineViewController.swift
//  Recipe
//
//  Created by apple on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Kingfisher

/// 我的界面
class MineViewController: PlainTableViewController {
    
    private var mineList = [MineHeaderItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navView.isHidden = true
        tableView.rowHeight = 56
        tableView.tableHeaderView = headerView
        tableView.register(MineHeaderItemCell.self, forCellReuseIdentifier: MineHeaderItemCell.cellIdentifier)
        tableView.snp.remakeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        headerView.chatClosure = { [weak self] tag in
            self?.chatItems(tag: tag)
        }
        
        requestMineDatas()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshCacheImage()
    }
    
    lazy var headerView: MineHeaderView = {
        let headerView = MineHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 230 + ez.screenStatusBarHeight))
        return headerView
    }()
    
    lazy var contentHeaderBackgroundView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.clear
        return iv
    }()
}

extension MineViewController {
    private func chatItems(tag: Int) {
        switch tag {
        case 0:
//            pushVC(MineDownViewController())
            break
        case 1:
//            pushVC(MineCollectionViewController())
            break
        case 2:
//            pushVC(BrowseRecordsViewController())
            break
        case 3:
            break
        default:
            break
        }
    }
    
    private func refreshCacheImage() {
        ImageCache.default.calculateDiskStorageSize { (result) in
            switch result {
            case .success(let usedDiskCacheSize):
                let cacheSize = Double(usedDiskCacheSize) / 1024 / 1024
                QL1("图片缓存的大小： \(usedDiskCacheSize)")
                self.mineList.first?.desc = String(format: "%.2fM", cacheSize)
                break
            default:
                break
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func requestMineDatas() {
        DispatchQueue.global().async {
            ImageCache.default.calculateDiskStorageSize { (result) in
                let cacheItem = MineHeaderItem(title: "清理缓存", icon: "mine_cell_icon_clear")
                switch result {
                case .success(let usedDiskCacheSize):
                    let cacheSize = Double(usedDiskCacheSize) / 1024 / 1024
                    QL1("图片缓存的大小： \(usedDiskCacheSize)")
                    cacheItem.desc = String(format: "%.2fM", cacheSize)
                    break
                default:
                    break
                }
                
                self.mineList.append(cacheItem)
                self.mineList.append(MineHeaderItem(title: "反馈问题", icon: "mine_cell_icon_feedback"))
                self.mineList.append(MineHeaderItem(title: "去评分", icon: "min_cell_icon_user"))
                self.mineList.append(MineHeaderItem(title: "用户协议", icon: "min_cell_icon_user"))
                self.mineList.append(MineHeaderItem(title: "隐私政策", icon: "mine_cell_icon_ptorocl"))
                self.mineList.append(MineHeaderItem(title: "关于我们", icon: "mine_cell_icon_me"))
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableView
extension MineViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return contentHeaderBackgroundView
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mineList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineHeaderItemCell.cellIdentifier, for: indexPath) as! MineHeaderItemCell
        cell.model = mineList[indexPath.row]
        if indexPath.row == 0 {
//            cell.isFirs = true
            cell.contentBackgroundView.setRoundCorners(corners: [.topLeft ,.topRight], with: 6)
        }
        if indexPath.row ==  mineList.count - 1 {
            cell.contentBackgroundView.setRoundCorners(corners: [.bottomLeft ,.bottomRight], with: 6)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = mineList[indexPath.row]
        switch model.title {
        case "清理缓存":
            let confit = CommonAlertManagerConfig(title: "确认要清除缓存吗？")
            confit.cancelTitle = "取消"
            CommonAlertController.show(inCtl: self, config: confit, agree: {
                ImageCache.default.clearMemoryCache()
                ImageCache.default.clearDiskCache()
                self.mineList.first?.desc = ""
                self.tableView.reloadData()
            }, cancel: nil)
            break
        case "意见反馈":
//            let ctl = ProfileFeedbackVC()
//            pushVC(ctl)
            break
        case "用户协议":
            let ctl = WebViewController()
            ctl.url = Configs.App.userProtocol
            pushVC(ctl)
            break
        case "隐私政策":
            let ctl = WebViewController()
            ctl.url = Configs.App.userScreet
            pushVC(ctl)
            break
        case "关于我们":
//            pushVC(MineAboutViewController())
            break
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }
}
