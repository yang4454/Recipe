//
//  FindHomeModel.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/9/7.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit
import HandyJSON

/// 发现首页模型
struct FindHomeModel: HandyJSON {
    var items: [HomeImageModel] = [HomeImageModel]()
    var keyword: String = ""
    var keywordId: String = ""
}
