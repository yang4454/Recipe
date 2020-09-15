//
//  RTProvider.swift
//  Rental
//
//  Created by Zack on 2020/3/10.
//  Copyright © 2020 ZK. All rights reserved.
//

import Foundation
import HandyJSON
import SwiftyJSON
import Moya

/// 请求协议
protocol MoyaRequestProtocol: HandyJSON {
    static func request(api: MoyaAPI,
                        result: @escaping ((MoyaResponseResult<Self>)->()))
}


extension MoyaRequestProtocol where Self: HandyJSON {

    /// 请求框架
    /// - Parameters:
    ///   - api: api
    ///   - result: 结果
    static func request(api: MoyaAPI,
                        result: @escaping ((MoyaResponseResult<Self>)->())) {
        Provider.request(api) { (responce) in
            switch responce {
            case .success(let moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    if Configs.logRequestResponce {
                        QL1(api)
                        QL1(JSON(json))
                    }
                    if let code = json["reCode"].string {
                        switch code {
                        case "SUCCESS", "X0000":
                            guard let obj = self.self.deserialize(from: json.rawString()) else {
                                QL4("数据转换失败")
                                result(.failure(MoyaBaseError(errorMsg: "数据转换失败")))
                                return
                            }
                            result(.success(obj))
                            break
                        case "X1003":// token不可为空
                            
                            break
                        case "X1004":
                            // 登录退出登录
                            
                            break
                        case "X1007": // 不存在 // 登录退出登录
                            
                            break
                        default:
                            let reMsg = json["reMsg"].string ?? "请求失败，请重新尝试"
                            let code = json["reCode"].string ?? "0"
                            result(.failure(MoyaBaseError(errorMsg: reMsg, code: code)))
                            break
                        }
                    } else {
                        result(.failure(MoyaBaseError(errorMsg: "没有数据放回", code: "-1")))
                    }
                    
                } catch{
                    
                }
                break
            case .failure(let error):
                QL4("网络连接失败: \(error)")
                ///处理错误 抛出去
                result(.failure(MoyaBaseError(errorMsg: "请求失败，请重新尝试")))
                break
            }
        }
    }
}
