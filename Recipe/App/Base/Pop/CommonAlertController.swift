//
//  RTAlertController.swift
//  Rental
//
//  Created by Zack on 2020/4/9.
//  Copyright © 2020 ZK. All rights reserved.
//

import UIKit

/// 用于配置的
class CommonAlertManagerConfig {
    var title: String
    var titleFont: UIFont = 14.mediumFont
    
    var agreeTitle: String = "确定"
    var cancelTitle: String = "我在想想"
    
    var agreeFontColor: UIColor = UIColor.white
    var cancelFontColor: UIColor = Configs.Color.mainColor
    var titleColor: UIColor = UIColor.kColor333
    
    var agreeFont: UIFont = 17.mediumFont
    var cancelFont: UIFont = 17.mediumFont
    
    var contentWidth: CGFloat = SCREEN_WIDTH - 120
    var contentHeight: CGFloat = 150
    
    var cancelBcColor: UIColor = UIColor.kColorf4
    var agreeBcColor: UIColor = Configs.Color.mainColor
    
    /// 是否只有一个统一按钮
    var isOnlyAgree: Bool = false
    
    init(title: String) {
        self.title = title
    }
}

/// 统一的默认弹窗
class CommonAlertController: ViewController {
    
    var agreeClosure: (() -> ())?
    var cancelClosure: (() -> ())?
    
    private var config: CommonAlertManagerConfig!
    
    
    /// 弹窗显示i
    /// - Parameters:
    ///   - inCtl: 父类控制器
    ///   - config: 配置文件
    ///   - agree: 同意的回调
    ///   - cancel: 取消的回调
    class func show(inCtl: UIViewController, config: CommonAlertManagerConfig, agree: @escaping (() -> ()), cancel:(() -> ())?) {
        let ctl = CommonAlertController(config: config)
        ctl.agreeClosure = agree
        ctl.cancelClosure = cancel
        
        let popupCtl = STPopupController(rootViewController: ctl)
        popupCtl.navigationBarHidden = true
        popupCtl.transitionStyle = .fade
        popupCtl.containerView.layer.cornerRadius = 16
        popupCtl.present(in: inCtl)
    }
    
    init(config: CommonAlertManagerConfig) {
        super.init(nibName: nil, bundle: nil)
        self.config = config
        self.contentSizeInPopup = CGSize(width: config.contentWidth, height: config.contentHeight)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navView.isHidden = true
        view.backgroundColor = UIColor.white
        
        if config.isOnlyAgree {
            view.addSubview(agreeBtn)
            agreeBtn.snp.makeConstraints { (make) in
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(-20)
                make.size.equalTo(CGSize(width: 210, height: 36))
            }
        } else {
            view.addSubview(cancelBtn)
            cancelBtn.snp.makeConstraints { (make) in
                make.right.equalTo(view.snp.centerX).offset(-8)
                make.bottom.equalTo(-20)
                make.size.equalTo(CGSize(width: 110, height: 36))
            }
            
            view.addSubview(agreeBtn)
            agreeBtn.snp.makeConstraints { (make) in
                make.left.equalTo(view.snp.centerX).offset(8)
                make.bottom.equalTo(-20)
                make.size.equalTo(CGSize(width: 110, height: 36))
            }
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 15, bottom: 76, right: 15))
        }
    }
    
    lazy var cancelBtn: UIButton = {
        let bc = UIButton(title: self.config.cancelTitle, font: 14.font, fontColor: self.config.cancelFontColor, backColor: self.config.cancelBcColor, target: self, action: #selector(self.cancelBtnClick))
        bc.titleLabel?.font = self.config.cancelFont
        bc.setCornerRadius(radius: 18)
        return bc
    }()
    
    lazy var agreeBtn: UIButton = {
        
        let bc = UIButton(title: self.config.agreeTitle, font: 14.font, fontColor: self.config.agreeFontColor, backColor: self.config.agreeBcColor, target: self, action: #selector(self.agreeBtnClick))
        bc.titleLabel?.font = self.config.agreeFont
        bc.setCornerRadius(radius: 18)
        return bc
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: self.config.titleFont, color: self.config.titleColor, alignment: .center)
        lb.numberOfLines = 0
        lb.text = self.config.title
        return lb
    }()
    
    @objc func cancelBtnClick() {
        self.popupController?.dismiss(completion: { [weak self] in
            self?.cancelClosure?()
        })
    }
    
    @objc func agreeBtnClick() {
        self.popupController?.dismiss(completion: { [weak self] in
            self?.agreeClosure?()
        })
    }
}
