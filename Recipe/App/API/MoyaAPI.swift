//
//  MoyaAPI.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/8/28.
//  Copyright © 2020 Zack. All rights reserved.
//

import Foundation
import Moya

enum MoyaAPI {
    /// 首页
    case wallpaperHome(dict: [String: Any])
    
    /// 推荐/最新/最热 壁纸列表
    case wallpaperList(dict: [String: Any])
    
    /// 所有列表
    case wallpaperSeriesList(dict: [String: Any])
    
    /// 系列.分类 下壁纸列表
    case wallpaperSeries(dict: [String: Any])
    
    /// 滑动
    case wallpaperSlide(dict: [String: Any])
    
    /// 意见反馈
    case wallpaperFeedback(dict: [String: Any])
    
    /// 获取临时访问凭证
    case getOssToken(dict: [String: Any])
    /// 版本信息
    case versionLatest(dict: [String: Any])
    
    /// 专题列表
    case wallpaperSpecialList(dict: [String: Any])
    /// 专题详情
    case wallpaperSpecial(dict: [String: Any])
    
    /// 发现首页
    case wallpaperSearchList(dict: [String: Any])
    /// 热门关键字
    case wallpaperSearchKeyword(dict: [String: Any])
    /// 关键字搜索
    case wallpaperSearch(dict: [String: Any])
}



extension MoyaAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getOssToken:
            return URL(string: "https://gateway.xmzt.cn")!
        default:
            return URL(string:"http://192.168.0.168:9002")!
        }
        
    }
    
    //不同接口的字路径
    var path: String {
        switch self {
        case .wallpaperHome:
            return "/wallpaper/home"
        case .wallpaperList:
            return "/wallpaper/list"
        case .wallpaperSeriesList:
            return "/wallpaper/series/list"
        case .wallpaperSeries:
            return "/wallpaper/series"
        case .wallpaperSlide:
            return "/wallpaper/slide"
            
        case .wallpaperFeedback:
            return "/wallpaper/feedback"
        case .getOssToken:
            return "/resource/open/getOssToken"
        case .versionLatest:
            return "/wallpaper/app/version/latest"
            
        case .wallpaperSpecialList:
            return "/wallpaper/special/list"
        case .wallpaperSpecial:
            return "/wallpaper/special"
            
        case .wallpaperSearchList:
            return "/wallpaper/search/list"
        case .wallpaperSearchKeyword:
            return "/wallpaper/search/keyword"
        case .wallpaperSearch:
            return "/wallpaper/search"
        }
        
    }
    
    /// 请求方式 get post put delete
    var method: Moya.Method {
        switch self {
        case .wallpaperFeedback:
            return .post
        default:
            return .get
        }
    }
    
    /// 这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .wallpaperHome(let dict),
             .wallpaperList(let dict),
             .wallpaperSeriesList(let dict),
             .wallpaperSeries(let dict),
             .wallpaperSlide(let dict),
             .getOssToken(let dict),
             .wallpaperSpecialList(let dict),
             .wallpaperSpecial(let dict),
             .wallpaperSearchList(let dict),
             .wallpaperSearchKeyword(let dict),
             .wallpaperSearch(let dict),
             .versionLatest(let dict):
            //后台的content-Type 为application/x-www-form-urlencoded时选择URLEncoding
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case .wallpaperFeedback(let dict):
            //后台可以接收json字符串做参数时选这个
            return .requestParameters(parameters: dict, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        //同task，具体选择看后台 有application/x-www-form-urlencoded 、application/json
        switch self {
        case .wallpaperFeedback:
            return ["Content-Type":"application/json;charset=utf-8",
            "Accept":"application/json",
            "client":"ios"]
        default:
            return ["Content-Type":"application/x-www-form-urlencoded;charset=utf-8",
            "Accept":"application/json",
            "client":"ios"]
        }
    }
    
    
}
