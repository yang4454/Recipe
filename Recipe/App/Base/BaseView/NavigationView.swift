//
//  NavigationView.swift
//  ChildrenNet
//
//  Created by Zack on 2020/4/24.
//  Copyright © 2020 ZK. All rights reserved.
//

import UIKit



/// 统一用自定义的导航栏
class NavigationView: UIView {
    
    var leftImageName: String? {
        didSet {
            guard let leftImageName = leftImageName else {
                return
            }
            leftNavBtn.setImage(leftImageName.image, for: .normal)
        }
    }
    
    var title: String? {
        didSet {
            guard let title = title else {
                return
            }
            titleLabel.text = title
        }
    }
    
    var leftItemHide: Bool? {
        didSet {
            guard let leftItemHide = leftItemHide else {
                return
            }
            leftNavBtn.isHidden = leftItemHide
        }
    }
    
    var rightItemHide: Bool? {
        didSet {
            guard let rightItemHide = rightItemHide else {
                return
            }
            rightNavBtn.isHidden = rightItemHide
        }
    }
    
    var showLine: Bool?{
        didSet {
            guard let showLine = showLine else {
                return
            }
            bottomLine.isHidden = !showLine
        }
    }
    
    
    
    var leftTapClosure:(() -> ())?
    var rightTapClosure:(() -> ())?

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: kStatusBarHeight + 44))
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 左边 leftItem
    lazy var leftNavBtn: UIButton = {
        let bc = UIButton(type: .custom)
        bc.setTitleColor(UIColor.kColor333, for: .normal)
        bc.addTarget(self, action: #selector(self.leftBtnClick), for: .touchUpInside)
        return bc
    }()
    
    lazy var rightNavBtn: NavRightButton = {
        let bc = NavRightButton(type: .custom)
        bc.setTitleColor(UIColor.kColor333, for: .normal)
        bc.titleLabel?.font = 14.font
        bc.titleLabel?.textAlignment = .center
        bc.sizeToFit()
        bc.addTarget(self, action: #selector(self.rightBtnClick), for: .touchUpInside)
        return bc
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 17.boldFont, color: UIColor.kColor333, alignment: .center)
        return lb
    }()
    
    lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0.00, alpha: 0.09)
        return line
    }()
}

// MARK: - Func
extension NavigationView {
    func setLeftItem(img: String, action: (() -> ())? = nil) {
        leftImageName = img
        if action != nil {
            leftTapClosure = action
        }
    }
    
    func setRightItem(image: UIImage? = nil, btnTitle: String? = nil, color: UIColor = UIColor.kColor333, action: @escaping (() -> ())) {
        rightNavBtn.setImage(image, for: .normal)
        rightNavBtn.setTitle(btnTitle, for: .normal)
        rightNavBtn.setTitleColor(color, for: .normal)
        rightTapClosure = action
    }
}

// MARK: - UI
extension NavigationView {
    func configUI() {
        backgroundColor = UIColor.white
        addSubview(leftNavBtn)
        leftNavBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.left.equalTo(10)
            make.top.equalTo(kStatusBarHeight)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.height.equalTo(leftNavBtn)
            make.left.lessThanOrEqualTo(56)
            make.right.lessThanOrEqualTo(-56)
        }
        
        addSubview(rightNavBtn)
        rightNavBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(leftNavBtn)
        }
        
        
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(1)
        }
    }
    
    @objc func leftBtnClick() {
        leftTapClosure?()
    }
    
    @objc func rightBtnClick() {
        rightTapClosure?()
    }
}


class NavRightButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let margin: CGFloat = 5
        let area = self.bounds.insetBy(dx: -margin, dy: -margin) //负值是方法响应范围
        return area.contains(point)
    }
}
