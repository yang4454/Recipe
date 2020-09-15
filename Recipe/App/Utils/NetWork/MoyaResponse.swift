//
//  RTProvider.swift
//  Rental
//
//  Created by Zack on 2020/3/10.
//  Copyright © 2020 ZK. All rights reserved.
//

import HandyJSON
import Foundation

public struct MoyaDataResponse<T>: MoyaRequestProtocol where T: HandyJSON {
    public init (){}
    public var reCode: String = ""
    public var reMsg: String = ""
    public var rel: T?
}

public struct MoyaListResponse<T>: MoyaRequestProtocol where T: HandyJSON {
    public init (){}
    public var reCode: String = ""
    public var reMsg: String = ""
    public var rel: [T] = []
}

public struct MoyaMsgResponse:  MoyaRequestProtocol {
    public init (){}
    public var reCode: String = ""
    public var reMsg: String = ""
    public var rel: String?
}

public struct MsgListResponse:  MoyaRequestProtocol {
    public init (){}
    public var reCode: String = ""
    public var reMsg: String = ""
    public var rel: [String] = [String]()
}


