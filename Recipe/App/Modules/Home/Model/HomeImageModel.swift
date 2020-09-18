//
//  HomeImageModel.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/9/7.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit
import HandyJSON

/// 图片模型
class HomeImageModel: HandyJSON {
    /// 缩略图
    var thumbnail: String = ""
    
    var id: String = ""
    
    /// 高清图
    var image: String = ""
    
    /// 简介
    var introduction: String = ""
    
    /// mp4
    var mp4: String = ""
    
    /// 别称
    var nickname: String = ""
    
    /// 标题
    var title: String = ""
    
    var score: Int = 0
    
    /// custom - 是否选中
    var selected: Bool = false
    
    required init() {
        
    }
}
