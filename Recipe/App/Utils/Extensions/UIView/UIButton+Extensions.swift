//
//  UIButton+Extensions.swift
//  Crosstalk
//
//  Created by Zack on 2018/6/1.
//  Copyright © 2018年 zack. All rights reserved.
//

import UIKit


// MARK: - UIButton的扩展
extension UIButton {
    
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, target: Any?, action: Selector) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    /// 用于左右item使用，默认尺寸30x30
    convenience init(item image: String, target: Any, action: Selector, size: CGFloat = 30) {
        self.init()
        let img = UIImage(named: image)
        setImage(img, for: .normal)
        frame = CGRect(x: 0, y: 0, w: size, h: size)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    
    /// 用于左右item使用，默认尺寸30x30
    convenience init(image: String, target: Any, action: Selector, size: CGFloat = 30) {
        self.init()
        let img = UIImage(named: image)
        setImage(img, for: .normal)
        frame = CGRect(x: 0, y: 0, width: size, height: size)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init(title: String, target: Any,action: Selector, font: UIFont, color: UIColor = UIColor.white, width: CGFloat = 44, height: CGFloat = 30) {
        self.init()
        setTitle(title, for: .normal)
        titleLabel?.font = font
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    
    convenience init(bcImage: String,target: Any, action: Selector) {
        self.init()
        let img = UIImage(named: bcImage)
        setBackgroundImage(img, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    /// 按钮
    ///
    /// - Parameters:
    ///   - title:          标题
    ///   - color:          颜色
    ///   - backimageName:  背景图片名词
    convenience init(title: String, color: UIColor, backimageName: String) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setBackgroundImage(UIImage(named:backimageName), for: .normal)
    }
    
    /// 按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - font: 字体
    ///   - fontColor: 颜色
    ///   - imageName: 图像名称
    convenience init(title: String, font: UIFont, fontColor: UIColor, imageName: String? = nil, backColor: UIColor? = nil, target: Any?, action: Selector) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(fontColor, for: .normal)
        if let imageName = imageName {
            setImage(UIImage(named:imageName), for: .normal)
        }
        backgroundColor = backColor
        titleLabel?.font = font
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    /// 按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - fontSize: 字体大小
    ///   - color: 颜色
    ///   - imageName: 图像名称
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String? = nil, backColor: UIColor? = nil, target: Any?, action: Selector) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        if let imageName = imageName {
            setImage(UIImage(named:imageName), for: .normal)
        }
        backgroundColor = backColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init(title : String , bgColor : UIColor , font : CGFloat) {
        self.init()
        setTitle(title, for: .normal)
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: font)
    }
    
    
    /// 图片在上，标题在下的按钮
    ///
    /// - Parameters:
    ///   - frame: 尺寸位置
    ///   - pading: 标题和图片间隔
    ///   - target: 点击代理
    ///   - action: 点击事件
    ///   - title: 标题
    ///   - titleColor: 标题颜色
    ///   - fontSize: 字体大小
    ///   - img: 图片
    convenience init(topImage frame: CGRect,
                     pading: CGFloat = 10,
                     target: Any?,
                     action: Selector,
                     title: String,
                     titleColor: UIColor = UIColor.white,
                     fontSize: CGFloat,img: String) {
        self.init(frame: frame)
        
        addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        
        setImage(UIImage(named: img), for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(titleColor, for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: self.imageView!.frame.size.height + pading, left: -self.imageView!.bounds.size.width, bottom: 0.0, right: 0.0);
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: self.titleLabel!.bounds.size.width  / 2, bottom: self.titleLabel!.frame.size.height + pading, right: -self.titleLabel!.bounds.size.width / 2);
    }
    
    
    /// 图片在上面
    func centerVertically(padding: CGFloat = 6.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
    
}

extension UIButton {
    
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}


extension UIButton {

    /// EZSwiftExtensions: Set a background color for the button.
    public func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}

// MARK: -  倒计时按钮
extension UIButton {
    public func countDown(count: Int){
        // 倒计时开始,禁止点击事件
        isEnabled = false
        // 保存当前的背景颜色
        let defaultColor = self.backgroundColor
        // 设置倒计时,按钮背景颜色
//        backgroundColor = UIColor.kColorf4
        var remainingCount: Int = count {
            willSet {
                setTitle("\(newValue)s", for: .normal)
                if newValue <= 0 {
                    setTitle("发送验证码", for: .normal)
                }
            }
        }
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                // 每秒计时一次
                remainingCount -= 1
                // 时间到了取消时间源
                if remainingCount <= 0 {
                    self.backgroundColor = defaultColor
                    self.isEnabled = true
                    codeTimer.cancel()
                }
            }
        })
        // 启动时间源
        codeTimer.resume()
        
    }
    

}
