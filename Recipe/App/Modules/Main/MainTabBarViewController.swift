//
//  MainTabBarViewController.swift
//  Recipe
//
//  Created by apple on 2020/9/14.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import ESTabBarController_swift

enum HomeTabBarItem: Int {
    case home, find,topic, profile
    
    var controller: NavigationController {
        switch self {
        case .home:
            let vc = HomeViewController()
            return NavigationController(rootViewController: vc)
        case .find:
            let vc = FindViewController()
            return NavigationController(rootViewController: vc)
        case .topic:
            let vc = TopicViewController()
            return NavigationController(rootViewController: vc)
        case .profile:
            let vc = MineViewController()
            return NavigationController(rootViewController: vc)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home:
            return "tab_home".image
        case .find:
            return "tab_find".image
        case .topic:
            return "tab_topic".image
        case .profile:
            return "tab_mine".image
        }
    }
    
    var selectedImage:UIImage? {
        switch self {
        case .home:
            return "tab_home_select".image
        case .find:
            return "tab_find_select".image
        case .topic:
            return "tab_topic_select".image
        case .profile:
            return "tab_mine_select".image
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "首页"
        case .find:
            return "发现"
        case .topic:
            return "主题"
        case .profile:
            return "我的"
        }
    }
}


class MainTabBarViewController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var navCtls: [NavigationController] = [NavigationController]()
        let items: [HomeTabBarItem] = [.home, .find, .topic, .profile]
        
        items.forEachEnumerated { (index, item) in
            let controller = item.controller
            controller.tabBarItem = ESTabBarItem(RTBasicContentView(), title: item.title, image: item.image, selectedImage: item.selectedImage)
            navCtls.append(controller)
        }
        
        viewControllers = navCtls
    }
  

}

class RTBasicContentView: ESTabBarItemContentView {
    public var duration = 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor(hexString: "0x9A9A9A")
        highlightTextColor = Configs.Color.mainColor
        renderingMode = .alwaysOriginal
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }

    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    /// 弹簧动画
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}
