//
//  UIBarButtonItem+Extension.swift
//  TLRadio
//
//  Created by Zack on 2019/3/12.
//  Copyright © 2019 Zack. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    
    convenience init(image: UIImage?, target: Any?, action: Selector, width: CGFloat = 30, height: CGFloat = 30) {
        let btn = UIButton(type: .custom)
        btn.setImage(image, for: .normal)
        btn.frame = CGRect(x: 0, y: 0, w: width, h: height)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}
