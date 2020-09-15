//
//  NSMutableAttributedString+Extensions.swift
//  DrivingTour
//
//  Created by Zack on 2019/7/13.
//  Copyright © 2019 Zack. All rights reserved.
//

import Foundation

extension String {

    /**
        let atrStr1 = "aaa".attribute()
        .font(.boldSystemFont(ofSize: 12))
        .textColor(.blue)
        .spacing(5)
     */
    func attribute() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
    
}

extension NSMutableAttributedString {
    
    
    /// 使用了YY的初始化
    /// - Parameters:
    ///   - string: 字符串
    ///   - font: 字体
    ///   - color: 颜色
    ///   - lineSpacing: 间距
    ///   - alignment: 排布
//    convenience init(string: String, font: UIFont, color: UIColor,
//                     lineSpacing: CGFloat = 4,
//                     alignment: NSTextAlignment = .left) {
//        self.init(string: string)
//
//        self.yy_font = font
//        self.yy_color = color
//        self.yy_lineSpacing = lineSpacing
//        self.yy_alignment = alignment
//    }
    
    convenience init(string: String, font: UIFont, color: UIColor,
                     lineSpacing: CGFloat = 4,
                     alignment: NSTextAlignment = .left) {
        self.init(string: string)
        self.yy_font = font
        self.yy_color = color
        self.yy_lineSpacing = lineSpacing
        self.yy_alignment = alignment
    }
    
}


extension NSMutableAttributedString {

    static func + (left: NSMutableAttributedString, right: NSMutableAttributedString) -> NSMutableAttributedString {
        left.append(right)
        return left
    }

    func font(_ font: UIFont) -> Self {
        addAttribute(.font, value: font, range: NSMakeRange(0, string.count))
        return self
    }

    func textColor(_ color: UIColor) -> Self {
        addAttribute(.foregroundColor, value: color, range: NSMakeRange(0, string.count))
        return self
    }

    func backgroundColor(_ color: UIColor) -> Self {
        addAttribute(.backgroundColor, value: color, range: NSMakeRange(0, string.count))
        return self
    }

    func baseLineOffset(_ offset: CGFloat) -> Self {
        addAttribute(.baselineOffset, value: offset, range: NSMakeRange(0, string.count))
        return self
    }

    func underline(color: UIColor, style: NSUnderlineStyle) -> Self {
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.underlineStyle : style.rawValue,
            NSAttributedString.Key.underlineColor : color
        ]
        addAttributes(attributes, range: NSMakeRange(0, string.count))
        return self
    }

    func spacing(_ spacing: CGFloat) -> Self {
        addAttribute(.kern, value: spacing, range: NSMakeRange(0, string.count))
        return self
    }
}

