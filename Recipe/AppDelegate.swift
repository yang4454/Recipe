//
//  AppDelegate.swift
//  Recipe
//
//  Created by apple on 2020/9/14.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Kingfisher
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = Configs.appRootController()
        window!.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showGuideNotifi), name: Notification.Name(rawValue: Configs.showGuideNotifi), object: nil)
        
        setupThirdParty()
        
        return true
    }
    
    @objc func showGuideNotifi() {
        window?.rootViewController = MainTabBarViewController()
    }


}

extension AppDelegate {
    private func setupThirdParty() {
        IQKeyboardManager.shared.enable = true
        setupKingfisher()
        #if DEBUG
        QorumLogs.enabled = true
        #else
        QorumLogs.enabled = false
        #endif
    }
    
    /// 设置图片缓存大小
    private func setupKingfisher() {
        // 设置磁盘缓存大小
        ImageCache.default.diskStorage.config.sizeLimit = UInt(500 * 1024 * 1024) // 500 MB
        // 设置缓存过期时间（默认是3天）
        ImageCache.default.diskStorage.config.expiration = .days(7) // 1 week
        // 设置超时时间(默认是15秒)
        ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
    }
}
