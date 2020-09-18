//
//  NavSearchView.swift
//  ChildrenNet
//
//  Created by Zack on 2020/5/11.
//  Copyright © 2020 ZK. All rights reserved.
//

import UIKit

/// 搜索视图顶部
class NavSearchView: BaseView {
    
    private var keyword: String = ""
    
    /// 搜索回调：字符串”“取消，count>0是字段搜索
    var searchClosure:((String) -> ())?
    var cancelClosure:(() -> ())?
    
    override func configUI() {
        backgroundColor = UIColor.clear
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(0)
            make.right.equalTo(-60)
            make.height.equalTo(32)
        }
        
        addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 32))
            make.left.equalTo(textField.snp.right)
            make.centerY.equalTo(self)
        }
    }
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.kColorf6
        tf.textColor = Configs.Color.black
        tf.attributedPlaceholder = NSMutableAttributedString(string: "想吃什么搜这里，如川菜", font: 14.font, color: UIColor.kColor999)
        tf.tintColor = UIColor.kColor333
        tf.font = 14.font
        tf.delegate = self
        tf.clearButtonMode = .whileEditing
        tf.returnKeyType = .search
        tf.addTarget(self, action: #selector(self.textDidChange(_:)), for: .editingChanged)
        tf.addLeftIcon("common_search_icon".image, frame: CGRect(x: 0, y: 0, w: 32, h: 30), imageSize: CGSize(width: 16, height: 16))
        tf.setCornerRadius(radius: 5)
        return tf
    }()
    
    lazy var btn: UIButton = {
        let bc = UIButton(title: "取消", font: 14.mediumFont, fontColor: UIColor.kColor666, target: self, action: #selector(self.searchBtnClick))
        return bc
    }()
    
    @objc func searchBtnClick() {
        textField.text = nil
        cancelClosure?()
    }

}

// MARK: - UITextField
extension NavSearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        searchClosure?(keyword)
        return true
    }
    
    @objc func textDidChange(_ textField:UITextField) {
        QL1("event:\(String(describing: textField.text))")
        keyword = textField.text ?? ""
    }
}
