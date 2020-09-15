//
//  Date+Extensions.swift
//  DrivingTour
//
//  Created by Zack on 2019/7/25.
//  Copyright © 2019 Zack. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func weekDay() -> String {
        let weekdays = ["周日", "周一","周二", "周三", "周四", "周五", "周六"]
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.component(.weekday, from: self)
        return weekdays[components - 1]
    }
    
    func weekDayType() -> String {
        let weekdays = ["星期天", "星期一","星期二", "星期三", "星期四", "星期五", "星期六"]
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.component(.weekday, from: self)
        return weekdays[components - 1]
    }
    
    /// Date类型转化为日期字符串
    ///
    /// - Parameters:
    ///   - date: Date类型
    ///   - dateFormat: 格式化样式默认“yyyy-MM-dd”
    /// - Returns: 日期字符串
    static func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
    }
    
    /// 日期字符串转化为Date类型
    ///
    /// - Parameters:
    ///   - string: 日期字符串
    ///   - dateFormat: 格式化样式，默认为“yyyy-MM-dd HH:mm:ss”
    /// - Returns: Date类型
    static func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    /// 当天零点的时间戳
    func getMorningDate() -> Date{
        let calendar = NSCalendar(identifier: .chinese)
        let components = calendar?.components([.year,.month,.day], from: self)
        return (calendar?.date(from: components!))!
    }

}
