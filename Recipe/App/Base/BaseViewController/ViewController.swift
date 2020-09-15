//
//  ViewController.swift
//  ChildrenNet
//
//  Created by Zack on 2020/4/23.
//  Copyright © 2020 ZK. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true // 全屏返回功能设置
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = UIColor.white
        view.addSubview(navView)
        navView.setLeftItem(img: "navigationbar_back") { [weak self] in
            self?.backAction()
        }
    }
    
    deinit {
        QL2("--- \(String(describing: self)) deinit ---")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    lazy var navView: NavigationView = {
        let iv = NavigationView(frame: CGRect.zero)
        return iv
    }()
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
}
