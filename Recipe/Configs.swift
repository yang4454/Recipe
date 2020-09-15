//
//  Configs.swift
//  Recipe
//
//  Created by apple on 2020/9/14.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import Kingfisher
import Toast_Swift

/// APP设置参数
struct Configs {
    
    static let showGuideNotifi = "showGuideNotifi"
    static let changeAgeCode = "changeAgeCodeNotifi"
    
    /// 是否打印请求的数据
    static let logRequestResponce = true
    
    static func toast(_ toast: String, druration: TimeInterval = 1) {
        DispatchQueue.main.async {
            UIView.viewToShow().makeToast(toast, duration: druration, position: .center)
        }
    }
    
    static var baseUrl: String = "https://api.app.61ertong.com"
    
    struct App {
        static let kAppleId = "917934524"
        
        static let bundleIdentifier = "com.gequ61.childrenNet"
        
        static let kDomainURL = "http://www.61ertong.com"
        
        static let kUniversivalLink = "https://weixin.app.61ertong.com/"
        
        static let kUMengKey = "544b5f8ffd98c50e6303ac59"
        static let kUmengChannel = "App Store"
        

        static let wechatKey = "wxe4ffeebd3d0b3afb"
        static let wechatSecret = "1d7f6150c844382d23107f01d0588eeb"
        
        static let qqKey = "1102490540"
        static let qqSecret = "9Z1hnB6sJkVHj0Yc"
        /// 用户协议
        static let userProtocol = "https://www.baidu.com/"
        /// 隐私政策
        static let userScreet = "https://www.baidu.com/"

    }
    
    struct Color {
        static let mainColor = UIColor(hexString: "#00CEBB")
        static let black = UIColor(hexString: "#4C3102")
        static let middle = UIColor(hexString: "#A19279")
        static let eb1 = UIColor(hexString: "#C8BEB1")
        static let lightBlack = UIColor(hexString: "#7A643F")
    }
    
    struct Images {
//        static let bigAvatar = UIImage(named: "profile_avatar")
//        static let middleAvatar = UIImage(named: "profile_avatar")
//        static let smallAvatar = UIImage(named: "profile_avatar")
        
        static let bannerPlaceholder = UIImage(named: "common_cell_place_img2")!
        static let cellPlaceholder = UIImage(named: "common_cell_place_img")!
        
        static let colorholder = UIImage.from(color: UIColor.kColorLine)
    }
    
    struct kf {
        /// 在显示和缓存之前将下载的图像转换成圆角，设置过度效果，淡入效果
        /// - Parameter radius: 圆角
        /// - Returns: 返回动画可选
        static func options(radius: CGFloat) -> KingfisherOptionsInfo {
            let processor = RoundCornerImageProcessor(cornerRadius: radius)
            return [.processor(processor), .transition(.fade(0.2))]
        }
        
        /// 在显示和缓存之前将下载的图像转换成圆角，设置过度效果，淡入效果
        static let options: KingfisherOptionsInfo = Configs.kf.options(radius: 20)
        static let options8: KingfisherOptionsInfo = Configs.kf.options(radius: 8)
    }
    
   

    /// 下载tu图片
    static func downImage(url: String, complete:((UIImage?) -> ())?) {
        ImageCache.default.retrieveImage(forKey: url) { result in
            switch result {
            case .success(let cache):
                complete?(cache.image)
                break
            case .failure(_):
                complete?(nil)
                break
            }
        }
    }
    
    static func appRootController() -> UIViewController {
        let bool = UserDefaults.standard.bool(forKey: "isShowGuidePage")
        if bool {
            return MainTabBarViewController()
        } else {
            /// 引导页
            UserDefaults.standard.set(true, forKey: "isShowGuidePage")
            UserDefaults.standard.synchronize()
//            return GuidePagesVC()
            return MainTabBarViewController()
        }
    }
}

extension Configs {

    static func tel(phone: String) {
        //自动打开拨号页面并自动拨打电话
        let urlString = "tel://" + phone
        if let url = URL(string: urlString) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    /// 跳转到AppStore
    static func  gotoAppStore() {
        let urlString = "itms-apps://itunes.apple.com/app/id" + Configs.App.kAppleId
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}


