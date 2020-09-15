//
//  String+Extensions.swift
//  DrivingTour
//
//  Created by Zack on 2019/7/12.
//  Copyright © 2019 Zack. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    var image: UIImage? {
        return UIImage(named: self)
    }
    
    var originalImage: UIImage? {
        return UIImage(named: self)?.withRenderingMode(.alwaysOriginal)
    }
    
    var ns: NSString {
        return self as NSString
    }
   
    var md5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)

        if let d = self.data(using: .utf8) {
            _ = d.withUnsafeBytes { body -> String in
                CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)
                return ""
            }
        }
        return (0 ..< length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    /// 转换分秒时间
    static func formatSecondsToString(_ seconds: TimeInterval) -> String {
        if seconds.isNaN {
            return "00:00"
        }
        let min = Int(seconds / 60)
        let sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", min, sec)
    }
    
    /// 转换小时分秒时间
    static func formatHourToString(_ seconds: TimeInterval) -> String {
        if seconds.isNaN {
            return "00:00:00"
        }
        let hour = Int(seconds / 60 / 60)
        let min = Int(seconds.truncatingRemainder(dividingBy: 60))
        let sec = Int(seconds.truncatingRemainder(dividingBy: 60).truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d:%02d",hour, min, sec)
    }
    
    static let random_str_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static func randomStr(len : Int) -> String{
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
    
    func isTelNumber()->Bool
    {
        if self.count != 11 { return false}
        /**
         * 手机号码: 更新 2018 - 12
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0,6, 7, 8], 18[0-9], 170[0-9]
         * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,1705,178,182,183,184,187,188,
         * 联通号段: 130 131 132 145 146 155 156 166  175 176 185 186
         * 电信号段: 133 149 153 173 174 177 180 181 189 199
         *  虚拟运营商
         电信：1700、1701、1702
         移动：1703、1705、1706
         联通：1704、1707、1708、1709、171
         */
        
        let mobile = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$" // 手机正则
        
        let  CM = "^1(34[0-8]|70[5]|(3[5-9]|4[78]|5[0-2,7-9]|8[0-9])\\d)\\d{7}$" // 移动
        let  CU = "^1(3[0-2]|4[56]|5[256]|8[56]|7[5-9])\\d{8}$" // 联通
        let  CT = "^1((33|49|53|8[019]|7[70])[0-9])\\d{7}$" // 电信
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    //返回第一次出现的指定子字符串在此字符串中的索引
    //（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)->Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    
    /// EZSE: Cut string from range
    func substring(integerRange: Range<Int>) -> String {
        let start = self.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = self.index(startIndex, offsetBy: integerRange.upperBound)
        return String(self[start..<end])
    }
    
    /// 将手机号15912341234中间5位替换成*
    func replaceByX(startIndex:Int,endIndex:Int) -> String {
        let start = self.index(self.startIndex, offsetBy: startIndex)
        let end = self.index(self.startIndex, offsetBy: endIndex)
        var str = String()
        for _ in 0..<endIndex - startIndex{
            str += "*"
        }
        return self.replacingCharacters(in: start..<end, with: str)
    }
    
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String,options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],range: NSMakeRange(0, self.count),withTemplate: with)
    }
    
    
}

extension String {
    /// 查找子串
    func ranges(of string: String) -> [Range<String.Index>] {
        var rangeArray = [Range<String.Index>]()
        var searchedRange: Range<String.Index>
        guard let sr = self.range(of: self) else {
            return rangeArray
        }
        searchedRange = sr
        
        var resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        while let range = resultRange {
            rangeArray.append(range)
            searchedRange = Range(uncheckedBounds: (range.upperBound, searchedRange.upperBound))
            resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        }
        return rangeArray
    }
    
    func nsrange(fromRange range : Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    /// 查找子串
    func nsranges(of string: String) -> [NSRange] {
        return ranges(of: string).map { (range) -> NSRange in
            self.nsrange(fromRange: range)
        }
    }
    
    /// 随机字符串
    static func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
}

// MARK: - 时间相关
extension String {
    /// 获取时间
    ///
    /// - Parameter format: 时间格式例如："yyyy-MM-dd"
    /// - Returns: date
    func getDate(format: String = "yyyy-MM-dd") -> Date? {
        let dataFormat = DateFormatter()
        dataFormat.dateFormat = format
        dataFormat.locale = Locale.current
        return dataFormat.date(from: self)
    }
    
    
    /// 返回日期格式字符串
    ///
    /// - Parameters:
    ///   - timeStamp: 时间戳
    ///   - format: 日期格式- 默认 yyyy-MM-dd HH:mm
    /// - Returns: 字符串
    static func dateString(timeStamp: String, format: String = "yyyy-MM-dd HH:mm") -> String? {
        if !timeStamp.isNumber() {return nil}
        let interval = timeStamp.toDouble() ?? Date().timeIntervalSince1970
        let formatter = DateFormatter()
        //        formatter.dateStyle = .medium
        //        formatter.locale = Locale.init(identifier: "zh_CN")
        //        formatter.timeStyle = .short
        formatter.dateFormat = format
        let date = Date(timeIntervalSince1970: interval)
        return formatter.string(from: date)
    }
    
    /// 时间戳 时间转换
    func time(format: String = "yyyy-MM-dd HH:mm") -> String {
        if !isNumber() {return self}
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let date = Date(timeIntervalSince1970: self.toDouble()!)
        return formatter.string(from: date)
    }
    
    
    
    /// 返回当前日期的描述信息
    /*
     刚刚（一分钟内）
     X分钟前（一小时内）
     X小时前（当天）
     昨天 HH：mm
     MM-dd HH：mm（一年内）
     yyyy-MM-dd HH：MM （更早期）
     
     */
    static func dateDescription(date: Date?) -> String {
        if date == nil {
            return ""
        }
        let calendar = Calendar.current
        //处理今天的日期
        if calendar.isDateInToday(date!) {
            let delta = Int(Date().timeIntervalSince(date!))
            if delta < 60 {
                return "刚刚"
            }
            if delta < 3600 {
                return "\(delta / 60)分钟前"
            }
            return "\(delta / 3600)小时前"
        }
        var fmt = " HH:mm"
        //根据格式字符串生成描述字符串
        let df = DateFormatter()
        df.locale = Locale(identifier: "en")
        
        if calendar.isDateInYesterday(date!) {
            df.dateFormat = fmt
            return "昨天" + df.string(from: date!)
        }else {
            fmt = "MM-dd" + fmt
            //canlendar.component(.year, from: date)  // 直接获取年的数值
            let comps = calendar.dateComponents([.year], from: date!, to: Date())
            if comps.year! > 0 {
                fmt = "yyyy-" + fmt
            }
        }
        
        df.dateFormat = fmt
        return df.string(from: date!)
    }
    
    
}
