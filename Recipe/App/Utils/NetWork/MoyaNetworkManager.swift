//
//  NetworkManager.swift
//  GuidedTour
//
//  Created by Zack on 2020/7/4.
//  Copyright © 2020 Zack. All rights reserved.
//

import Moya
import Alamofire
import Foundation
import HandyJSON
import SwiftyJSON

/// 超时时长
private var requestTimeOut: Double = 30
/// 成功数据的回调
typealias successCallback = ((String) -> Void)
/// 失败的回调
typealias failedCallback = ((String) -> Void)
/// 网络错误的回调
typealias errorCallback = (() -> Void)

/// 网络请求的基本设置,这里可以拿到是具体的哪个网络请求，可以在这里做一些设置
private let myEndpointClosure = { (target: MoyaAPI) -> Endpoint in
    /// 这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug https://github.com/Moya/Moya/issues/1198
    let url = target.baseURL.absoluteString + target.path
    var task = target.task

    /*
     如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
     👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
     */
//    let additionalParameters = ["token":DTUserInfo.shared().userToken] // 0bf74ae1546de1acdf5198da3b729b3a
//    let defaultEncoding = URLEncoding.default
//    switch target.task {
//        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
//    case .requestPlain:
//        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
//    case .requestParameters(var parameters, let encoding):
//        additionalParameters.forEach { parameters[$0.key] = $0.value }
//        task = .requestParameters(parameters: parameters, encoding: encoding)
//    default:
//        break
//    }
    /*
     👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆
     如果需要在每个请求中都添加类似token参数的参数请取消注释上面代码
     */

    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    requestTimeOut = 30 // 每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置
//    switch target {
//    case .register:
//        requestTimeOut = 5
//        return endpoint
//    default:
//
//    }
    
    return endpoint
}

/// NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示
/// 但这里我没怎么用这个。。。 loading的逻辑直接放在网络处理里面了
private let networkPlugin = NetworkActivityPlugin.init { changeType, _ in
    QL1("networkPlugin \(changeType)")
    // targetType 是当前请求的基本信息
    switch changeType {
    case .began:
        QL1("开始请求网络")
    case .ended:
        QL2("结束")
    }
}

/// 网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        // 设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            QL1("\(request.url!)" + "\n" + "\(request.httpMethod ?? "")" + "发送参数" + "\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        } else {
            QL1("\(request.url!)")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}


/// /网络请求发送的核心初始化方法，创建网络请求对象
let Provider = MoyaProvider<MoyaAPI>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)

