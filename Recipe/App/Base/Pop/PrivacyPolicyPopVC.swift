//
//  PrivacyPolicyPopVC.swift
//  ChildrenNet
//
//  Created by Zack on 2020/4/27.
//  Copyright © 2020 ZK. All rights reserved.
//

import UIKit

private let kServiceAndPolicyWidth: CGFloat = 300
private let kServiceAndPolicyHeight: CGFloat = 375
private let kServiceAndPolicyShow: String = "AppServiceAndPolicy"

/// 隐私政策协议
class PrivacyPolicyPopVC: UIViewController {
    
    private var complete:(() -> ())?
    
    /// 显示 服务协议及隐私政策
    /// - Parameter inCtl: 父类控制器
    class func show(inCtl: UIViewController, complete: @escaping (() -> ())) {
        let isShow = UserDefaults.standard.bool(forKey: kServiceAndPolicyShow)
        if isShow {
            return
        }
        
        let ctl = PrivacyPolicyPopVC()
        ctl.complete = complete
        
        let popupCtl = STPopupController(rootViewController: ctl)
        popupCtl.navigationBarHidden = true
        popupCtl.transitionStyle = .fade
        popupCtl.containerView.layer.cornerRadius = 16 // 加了这个之后不用设置safeAreaInsets
        popupCtl.present(in: inCtl)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.contentSizeInPopup = CGSize(width: kServiceAndPolicyWidth, height: kServiceAndPolicyHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(26)
            make.height.equalTo(24)
        }
        
        view.addSubview(descLabel)
        
        view.addSubview(cancenBtn)
        cancenBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 120, height: 36))
        }
        
        view.addSubview(okBtn)
        okBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 120, height: 36))
        }
        
        configlayout()
    }
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 17.boldFont, color: UIColor.kColor333, alignment: .center)
        lb.text = "服务协议及隐私政策"
        return lb
    }()
    
    lazy var descLabel: YYLabel = {
        let lb = YYLabel()
        lb.size = CGSize(width: kServiceAndPolicyWidth - 56, height: kServiceAndPolicyHeight - 66 - 66)
        lb.left = 28
        lb.top = 66
        lb.textVerticalAlignment = .top
        lb.preferredMaxLayoutWidth = kServiceAndPolicyWidth - 56
        lb.displaysAsynchronously = true //开启异步绘制
        lb.ignoreCommonProperties = true //忽略除了 textLayout 之外的其他属性
        lb.fadeOnAsynchronouslyDisplay = false
        lb.fadeOnHighlight = false
        return lb
    }()
    
    lazy var cancenBtn: UIButton = {
        let btn = UIButton(title: "暂不使用", font: 17.font, fontColor: Configs.Color.mainColor, backColor: UIColor(hexString: "0xF6F6F6"), target: self, action: #selector(self.cancelBtnClick))
        btn.setCornerRadius(radius: 18)
        return btn
    }()
    
    lazy var okBtn: UIButton = {
        let btn = UIButton(title: "同意", font: 17.font, fontColor: UIColor.white, backColor: Configs.Color.mainColor, target: self, action: #selector(self.okBtnClick))
        btn.setCornerRadius(radius: 18)
        return btn
    }()
    
}

extension PrivacyPolicyPopVC {
    private func configlayout() {
        DispatchQueue.global().async {
            let text = "感谢您信任并使用高清美图壁纸！\n"
            let text2 = "高清美图壁纸专注于为用户提供优质的壁纸，为了更好的功能我们需要您同意通知、储存等授权。\n"
            let text3 = "尊重用户个人隐私是高清美图壁纸的一项基本政策。您在使用我们的产品与服务前请仔细阅读《用户协议》和《隐私政策》，如您同意，请点击“同意”开始接受我们的服务。"
            
            let attri = NSMutableAttributedString(string: text, font: 14.font, color: UIColor.kColor333)
            
            let attriText2 = NSMutableAttributedString(string: text2, font: 14.font, color: UIColor.kColor333)
            attriText2.yy_setFirstLineHeadIndent(20, range: attriText2.yy_rangeOfAll())
            
            attri.append(attriText2)
            
            
            let attriText3 = NSMutableAttributedString(string: text3, font: 14.font, color: UIColor.kColor333)
            let ranges = text3.nsranges(of: "《用户协议》")
            let ranges2 = text3.nsranges(of: "《隐私政策》")
            if ranges.count > 0 {
                let range = ranges.first!
                attriText3.yy_setColor(Configs.Color.mainColor, range: range)
                attriText3.yy_setTextHighlight(range, color: Configs.Color.mainColor, backgroundColor: UIColor.kColorf4) { [weak self] (_, _, _, _) in
                    QL1("《用户协议》")
                    self?.pushProcotolCtl(index: 1)
                }
            }
            if ranges2.count > 0 {
                let range = ranges2.first!
                attriText3.yy_setColor(Configs.Color.mainColor, range: range)
                attriText3.yy_setTextHighlight(range, color: Configs.Color.mainColor, backgroundColor: UIColor.kColorf4) { [weak self] (_, _, _, _) in
                    QL1("《隐私政策》")
                    self?.pushProcotolCtl(index: 2)
                }
            }
            attriText3.yy_setFirstLineHeadIndent(20, range: attriText3.yy_rangeOfAll())
            
            attri.append(attriText3)
            
            let container = YYTextContainer()
            container.size = CGSize(width: kServiceAndPolicyWidth - 56, height: CGFloat.greatestFiniteMagnitude)
            
            let modifier = TextLinePositionModifier()
            modifier.font = 14.font
            container.linePositionModifier = modifier
            
            let layout = YYTextLayout(container: container, text: attri)
            DispatchQueue.main.async {
                self.descLabel.textLayout = layout
            }
        }
    }
    
    @objc func cancelBtnClick() {
        UserDefaults.standard.set(false, forKey: kServiceAndPolicyShow)
        UserDefaults.standard.synchronize()
        exit(0)
    }
    
    @objc func okBtnClick() {
        UserDefaults.standard.set(true, forKey: kServiceAndPolicyShow)
        UserDefaults.standard.synchronize()
        self.popupController?.dismiss(completion: { [weak self] in
            self?.complete?()
        })
        
    }
    
    private func pushProcotolCtl(index: Int) {
        let webCtl = RTPopWebVC()
        webCtl.url = index == 1 ? Configs.App.userProtocol : Configs.App.userScreet
        self.popupController?.push(webCtl, animated: true)
    }
}

/// 弹窗跳转的控制器
class RTPopWebVC: WebViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.contentSizeInPopup = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navView.leftTapClosure = { [weak self] in
            self?.popupController?.popViewController(animated: true)
        }
    }
}
