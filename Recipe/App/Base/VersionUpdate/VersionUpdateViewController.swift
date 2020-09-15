//
//  VersionUpdateViewController.swift
//  WallpaperAPP
//
//  Created by Zack on 2020/9/11.
//  Copyright © 2020 Zack. All rights reserved.
//

import UIKit
import HandyJSON

/// 宽度
private let kHomeVersionContntWidth: CGFloat = 294
private let kHomeVersionTopIconHeight: CGFloat = 167
/// 版本升级控制器
class VersionUpdateViewController: UIViewController {
    class func show(inCtl: UIViewController) {
        let params = ["appType": "1", "clientType": "IOS"]
        MoyaDataResponse<AppVersionVO>.request(api: .versionLatest(dict: params)) { (response) in
            guard response.isSuccess else { return }
            guard let updateModel = response.value?.rel else { return }
            
            let version = updateModel.version.contains("V") ? updateModel.version.replacingOccurrences(of: "V", with: "") : updateModel.version
            guard let ezVersion = ez.appVersion else { return }
            if version.compare(ezVersion, options: .numeric) != .orderedDescending {
                return
            }
            updateModel.calculateData()
            
            QL2("商店版本比较新")
            let ctl = VersionUpdateViewController(model: updateModel)
            let popupCtl = STPopupController(rootViewController: ctl)
            popupCtl.navigationBarHidden = true
            popupCtl.transitionStyle = .fade
            popupCtl.containerView.backgroundColor = UIColor.clear
            popupCtl.safeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            popupCtl.present(in: inCtl)
        }
        
        
    }
    
    private var model: AppVersionVO!
    
    init(model: AppVersionVO) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        self.contentSizeInPopup = CGSize(width: kHomeVersionContntWidth, height: model.totalHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-45)
            make.top.equalTo(kHomeVersionTopIconHeight - 8)
        }
        view.addSubview(topIcon)
        topIcon.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(kHomeVersionTopIconHeight)
        }
        
        view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.size.equalTo(25.size)
            make.bottom.equalTo(0)
            make.centerX.equalTo(view)
        }
        
        contentView.addSubview(updateBtn)
        updateBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 243, height: 34))
            make.centerX.equalTo(view)
            make.bottom.equalTo(-22)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(8)
            make.height.equalTo(22)
        }
        contentView.addSubview(descLabel)
        contentView.addSubview(updateLabel)
        
        titleLabel.text = model.title + model.version
        descLabel.attributedText = model.tagText
        descLabel.textAlignment = .center
        cancelBtn.isHidden = model.forceUpgrade
        
        updateLabel.top = descLabel.frame.maxY + 12
        updateLabel.textLayout = model.updateLayout
        updateLabel.h = model.updateLayout?.textBoundingSize.height ?? 20
    }
    
    lazy var topIcon: UIImageView = {
        let bc = UIImageView()
        bc.image = UIImage(named: "update_bc_top")
        return bc
    }()
    
    lazy var contentView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.white
        iv.setCornerRadius(radius: 8)
        return iv
    }()
    lazy var cancelBtn: UIButton = {
        let bc = UIButton(bcImage: "update_btn_cancel", target: self, action: #selector(self.cancelBtnClick))
        return bc
    }()
    
    lazy var updateBtn: UIButton = {
        let bc = UIButton(bcImage: "update_btn_update", target: self, action: #selector(self.updateBtnClick))
        return bc
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel(font: 16.mediumFont, color: UIColor.kColor333, alignment: .center)
        lb.sizeToFit()
        return lb
    }()
    
    // tag描述标语
    private lazy var descLabel: YYLabel = {
        let lb = YYLabel()
        lb.size = CGSize(width: kHomeVersionContntWidth - 40, height: 20)
        lb.left = 20
        lb.top = 40
        lb.numberOfLines = 0
        return lb
    }()
    
    /// 更新的内容
    private lazy var updateLabel: YYLabel = {
        let lb = YYLabel()
        lb.size = CGSize(width: kHomeVersionContntWidth - 40, height: 20)
        lb.left = 20
        lb.top = 60
        lb.textVerticalAlignment = .top
        lb.preferredMaxLayoutWidth = kHomeVersionContntWidth - 40
        lb.displaysAsynchronously = true //开启异步绘制
        lb.ignoreCommonProperties = true //忽略除了 textLayout 之外的其他属性
        lb.fadeOnAsynchronouslyDisplay = false
        lb.fadeOnHighlight = false
        return lb
    }()

}

// MARK: - Function
extension VersionUpdateViewController {
    @objc func updateBtnClick() {
        Configs.gotoAppStore()
    }
    
    @objc func cancelBtnClick() {
        popupController?.dismiss()
    }
}

/// 版本升级模型
class AppVersionVO: HandyJSON {
    /// 1:android，2:ios
    var clientType: Int = 2
    
    /// 版本描述
    var content: String = ""
    
    /// 是否强制升级
    var forceUpgrade: Bool = false
    
    /// 是否最新
    var latest: Bool = false
    
    /// 版本标语
    var tagline: String = ""
    
    /// 版本名称
    var title: String = ""
    
    /// 资源地址
    var url: String = ""
    
    /// 版本号 e.g. v1.0.0
    var version: String = ""
    
    // 测试
    var tagText: NSMutableAttributedString?
    var tagHeight: CGFloat = 20
    var updateLayout: YYTextLayout?
    
    /// 容器高度
    var totalHeight: CGFloat = 0
    
    required init() {
        
        
    }
}

extension AppVersionVO {
    /// 计算数据
    func calculateData() {
        tagText = NSMutableAttributedString(string: tagline, font: 14.font, color: UIColor.kColor999)
        
        let contentAttri = NSMutableAttributedString(string: content, font: 14.font, color: UIColor.kColor333)
        let container = YYTextContainer(size: CGSize(width: kHomeVersionContntWidth - 40, height: CGFloat.greatestFiniteMagnitude))
        updateLayout = YYTextLayout(container: container, text: contentAttri)
        
        calculateViewHeight()
    }
    
    private func calculateViewHeight() {
        var height: CGFloat = 170 // 顶部高度
        height += 44 // 版本和标题
        // tag文本高度
        tagHeight = max(tagline.height(kHomeVersionContntWidth - 40, font: 14.font, lineBreakMode: nil), 20)
        height += tagHeight
        
        height += 20 // 间隙
        
        // 文本描述高度
        let updateHeight = max((updateLayout?.textBoundingSize.height ?? 20), 20)
        height += updateHeight
        height += 20 // 间隙
        height += 44 // 按钮
        height += 45 // 取消按钮
        totalHeight = height
    }
}
