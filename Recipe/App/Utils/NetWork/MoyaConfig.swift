//
//  MoyaConfig.swift
//  GuidedTour
//
//  Created by Zack on 2020/7/4.
//  Copyright © 2020 Zack. All rights reserved.
//

import Foundation
import UIKit
import Moya
import Alamofire

extension UIDevice {
    static var isNetworkConnect: Bool {
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true // 无返回就默认网络已连接
    }
}

