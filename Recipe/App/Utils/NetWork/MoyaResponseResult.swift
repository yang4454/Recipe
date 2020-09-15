//
//  RTProvider.swift
//  Rental
//
//  Created by Zack on 2020/3/10.
//  Copyright © 2020 ZK. All rights reserved.
//

import Foundation

/// 错误对象
class MoyaBaseError: NSObject {
    var code: String = ""
    var errorMsg: String = ""
    
    init(errorMsg: String = "",code: String = "") {
        super.init()
        self.errorMsg = errorMsg
        self.code = code
    }
}


enum MoyaResponseResult<Value> {
    case success(Value)
    case failure(MoyaBaseError)
    
    /// 是否成功
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    /// 是否失败
    var isFailure: Bool {
        return !isSuccess
    }
    
    /// 返回结果或者nil
    var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// 返回错误或者nil
    var error: MoyaBaseError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
