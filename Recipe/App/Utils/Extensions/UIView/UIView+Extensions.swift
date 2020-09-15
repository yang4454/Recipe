//
//  UIView+Extensions.swift
//  DrivingTour
//
//  Created by Zack on 2019/7/20.
//  Copyright © 2019 Zack. All rights reserved.
//

import Foundation
import UIKit



// MARK: - roundCorners
extension UIView {
    /// 设置圆角
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    //设置部分圆角
    func setRoundCorners(corners:UIRectCorner,with radii:CGFloat){
        let bezierpath:UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer()
        shape.path = bezierpath.cgPath
        self.layer.mask = shape
    }

    
    /// 去除圆角
    func noCornerMask() {
        layer.mask = nil
    }
    
    class func viewToShow() -> UIView {
        var window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin
                    break
                }
            }
        }
        return window ?? UIView()
    }
}

// MARK: - Line
extension UIView {
    func addBottomLine(height: CGFloat = 0.5, color: UIColor = kCellLineColor, pading: CGFloat = 0) {
        let exten_line = UIView()
        exten_line.backgroundColor = color
        addSubview(exten_line)
        exten_line.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(pading)
            make.right.equalTo(-pading)
            make.height.equalTo(height)
        }
    }
    
    func addBottom(height: CGFloat = 1, color: UIColor? = UIColor(hexString: "#F8F8F8"), leftPad: CGFloat = 0, rightPad: CGFloat = 0) {
        let exten_line = UIView()
        exten_line.backgroundColor = color
        addSubview(exten_line)
        exten_line.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(leftPad)
            make.right.equalTo(-rightPad)
            make.height.equalTo(height)
        }
    }
    
    func addTopLine(height: CGFloat = 1, color: UIColor? = UIColor(hexString: "#F8F8F8"), leftPad: CGFloat = 0, rightPad: CGFloat = 0) {
        let exten_line = UIView()
        exten_line.backgroundColor = color
        addSubview(exten_line)
        exten_line.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(leftPad)
            make.right.equalTo(-rightPad)
            make.height.equalTo(height)
        }
    }
}

extension UIView{
    //MARK:- 绘制虚线
    func drawDashLine(_ lineView:UIView,strokeColor: UIColor, lineWidth: CGFloat = 1, lineLength: Int = 10, lineSpacing: Int = 5) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = lineView.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        //每一段虚线长度 和 每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        
        let path = CGMutablePath()
//        let y = lineView.layer.bounds.height - lineWidth
        let x = lineView.layer.bounds.width - lineWidth
        path.move(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x, y: lineView.layer.bounds.height))
        shapeLayer.path = path
        lineView.layer.addSublayer(shapeLayer)
    }
}
