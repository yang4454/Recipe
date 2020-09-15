//
//  TextLinePositionModifier.swift
//  TLRadio
//
//  Created by Zack on 2019/3/9.
//  Copyright © 2019 Zack. All rights reserved.
//

import UIKit


/// 文本 Line 位置修改, 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
class TextLinePositionModifier: NSObject {

     /// 行距倍数
    var lineHeightMultiple: CGFloat = 1.34
    
    /// 文本底部留白
    var paddingBottom: CGFloat = 10
    
    /// 文本顶部留白
    var paddingTop: CGFloat = 10
    
    
    /*
     将每行的 baseline 位置固定下来，不受不同字体的 ascent/descent 影响。
     
     注意，Heiti SC 中，    ascent + descent = font size，
     但是在 PingFang SC 中，ascent + descent > font size。
     所以这里统一用 Heiti SC (0.86 ascent, 0.14 descent) 作为顶部和底部标准，保证不同系统下的显示一致性。
     间距仍然用字体默认
     */
    /// 基准字体 (例如 Heiti SC/PingFang SC)
    var font: UIFont = UIFont(name: "Heiti SC", size: 17)!
    
    func height(with lineCount: UInt) -> CGFloat {
        if lineCount == 0 {return 0}
        let asscent = font.pointSize * 0.86
        let descent = font.pointSize * 0.14
        let lineHeight = font.pointSize * lineHeightMultiple
        return paddingTop + paddingBottom + asscent + descent + CGFloat(lineCount - 1) * lineHeight
    }
    
}


extension TextLinePositionModifier: YYTextLinePositionModifier {
    func modifyLines(_ lines: [YYTextLine], fromText text: NSAttributedString, in container: YYTextContainer) {
        let ascent = font.pointSize * 0.86
        
        let lineHeight = font.pointSize * lineHeightMultiple
        for line in lines {
            var position = line.position
            position.y = paddingTop + ascent + CGFloat(line.row) * lineHeight
            line.position = position
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return TextLinePositionModifier()
    }
    
    
}
