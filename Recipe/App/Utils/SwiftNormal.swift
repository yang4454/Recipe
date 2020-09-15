//
//  SwiftNormal.swift
//  DrivingTour
//
//  Created by Zack on 2019/7/12.
//  Copyright © 2019 Zack. All rights reserved.
//

import Foundation

public let kScreenW: CGFloat = UIScreen.main.bounds.width
public let kScreenH: CGFloat = UIScreen.main.bounds.height

let kCellPadding: CGFloat = 12 /// cell 内边距
let kCellContentWidth: CGFloat = kScreenW - 2 * kCellPadding // cell 内容宽度
let kCellNameWidth: CGFloat = kScreenW - 110 //cell 名字最宽限制

/// 屏幕bounds
let SCREEN_BOUNDS = UIScreen.main.bounds
/// 全局遮罩透明度
let GLOBAL_SHADOW_ALPHA: CGFloat = 0.5
/// 全局边距
let MARGIN: CGFloat = 12

/// 全局圆角
let CORNER_RADIUS: CGFloat = 5

/// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.width
/// 屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
