//
//  UIImage+Extensions.swift
//  DrivingTour
//
//  Created by Zack on 2019/7/24.
//  Copyright © 2019 Zack. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static let placeImage = UIImage.from(color: UIColor.kColorCellLine)
    
    /*
     将图片等比例缩放, 缩放到图片的宽度等屏幕的宽度
     */
    func displaySize() -> CGSize {
        // 新的高度 / 新的宽度 = 原来的高度 / 原来的宽度
        
        // 新的宽度
        let newWidth = SCREEN_WIDTH
        
        // 新的高度
        let newHeight = newWidth * size.height / size.width
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        return newSize
    }
    
    /// 创建纯色图片
    static func from(color: UIColor, width: CGFloat = 1, height: CGFloat = 1) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    /// 颜色转图片
    ///
    /// - Parameter color: 颜色
    /// - Returns: 图片
    class func color(color: UIColor) -> UIImage {
        return UIImage.from(color: color)
    }
    
     /// 根据颜色创建图片
    public func withColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context?.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }

    
}

/// 图片添加水印
extension UIImage{
    //水印位置枚举
    enum WaterMarkCorner{
        case TopLeft
        case TopRight
        case BottomLeft
        case BottomRight
    }
     
    //添加图片水印方法
    func waterMarkedImage(waterMarkImage:UIImage, corner:WaterMarkCorner = .BottomRight,
                          margin:CGPoint = CGPoint(x: 20, y: 20), alpha:CGFloat = 1) -> UIImage{
         
        var markFrame = CGRect(x:0, y: 0, width:waterMarkImage.size.width,
                               height: waterMarkImage.size.height)
        let imageSize = self.size
         
        switch corner{
        case .TopLeft:
            markFrame.origin = margin
        case .TopRight:
            markFrame.origin = CGPoint(x: imageSize.width - waterMarkImage.size.width - margin.x,
                                       y: margin.y)
        case .BottomLeft:
            markFrame.origin = CGPoint(x: margin.x,
                                       y: imageSize.height - waterMarkImage.size.height - margin.y)
        case .BottomRight:
            markFrame.origin = CGPoint(x: imageSize.width - waterMarkImage.size.width - margin.x,
                                       y: imageSize.height - waterMarkImage.size.height - margin.y)
        }
         
        // 开始给图片添加图片
        UIGraphicsBeginImageContext(imageSize)
        self.draw(in: CGRect(x: 0, y:0, width: imageSize.width, height: imageSize.height))
        waterMarkImage.draw(in: markFrame, blendMode: .normal, alpha: alpha)
        let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        return waterMarkedImage!
    }
}

// MARK: 图片设置圆角
extension UIImage {
    
    public func roundImage(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadi: CGFloat) -> UIImage? {
        return roundImage(byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: cornerRadi, height: cornerRadi))
    }
    
    public func roundImage(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadii: CGSize) -> UIImage? {
        
        let imageRect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return nil
        }
        context?.setShouldAntialias(true)
        let bezierPath = UIBezierPath(roundedRect: imageRect,
                                      byRoundingCorners: byRoundingCorners,
                                      cornerRadii: cornerRadii)
        bezierPath.close()
        bezierPath.addClip()
        self.draw(in: imageRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 重新绘制图片
    ///
    /// - Parameters:
    ///   - image: 原图
    ///   - size: 绘制尺寸
    /// - Returns: 新图
    func redrawImage(size: CGSize?) -> UIImage? {
        // 绘制区域
        let rect = CGRect(origin: CGPoint(), size: size ?? CGSize.zero)
        // 开启图形上下文 size:绘图的尺寸 opaque:不透明 scale:屏幕分辨率系数,0会选择当前设备的屏幕分辨率系数
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        // 绘制 在指定区域拉伸并绘制
        draw(in: rect)
        // 从图形上下文获取图片
        let result = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return result
    }
    
    /// 重新绘制圆形图片
    ///
    /// - Parameters:
    ///   - image: 原图
    ///   - size: 绘制尺寸
    ///   - bgColor: 裁剪区域外的背景颜色
    /// - Returns: 新图
    func redrawOvalImage(size: CGSize?, bgColor: UIColor?) -> UIImage? {
        // 绘制区域
        let rect = CGRect(origin: CGPoint(), size: size ?? CGSize.zero)
        // 开启图形上下文 size:绘图的尺寸 opaque:不透明 scale:屏幕分辨率系数,0会选择当前设备的屏幕分辨率系数
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        // 背景颜色填充
        bgColor?.setFill()
        UIRectFill(rect)
        // 圆形路径
        let path = UIBezierPath(ovalIn: rect)
        // 进行路径裁切，后续的绘图都会出现在这个圆形路径内部
        path.addClip()
        // 绘制图像 在指定区域拉伸并绘制
        draw(in: rect)
        // 从图形上下文获取图片
        let result = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return result
    }
}
