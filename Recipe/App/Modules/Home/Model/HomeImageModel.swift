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
    required init() {
        
    }
    
    
    var score: Int = 0
    
    /// custom - 是否选中
    var selected: Bool = false
    
    
    /// 缩略图
    var thumbnail: String = ""
    
    var id: String = ""
    
    /// 高清图
    var image: String = ""
    
    
    /// mp4
    var mp4: String = ""
    
    /// 别称
    var nickname: String = ""
    
    /// 标题
    var title: String = ""
    
    
    //浏览量
    var seeNumber: Int = 0
    //收藏量
    var starNumber: Int = 0
    
    /// 简介
    var introduction: String = ""
    
    //食材清单
    struct ingredientsList {
        var ingredientsListGood: String = ""
        var ingredientsListNumber: String = ""
    }
    //烹饪做法
    struct practiceCooking {
        var practiceCookingImage: String = ""
        var practiceCookingTitle: String = ""
    }
    
    init(title: String,seeNumber: Int,starNumber: Int,introduction: String,image: String = "") {
        self.title = title
        self.seeNumber = seeNumber
        self.starNumber = starNumber
        self.introduction = introduction
        self.image = image
        
    }
}
