//
//  EZ+Extensions.swift
//  DrivingTour
//
//  Created by Zack on 2019/7/16.
//  Copyright © 2019 Zack. All rights reserved.
//

import UIKit

extension ez {
    
    static var isIPhoneX: Bool {
        if UIScreen.main.bounds.height == 812 || UIScreen.main.bounds.height == 896 { // X XR
            return true
        }
        return false
    }
    
    static var safeAreaTopHeight: CGFloat {
        return ez.screenStatusBarHeight + 44
    }
    
    static var safeAreaBottomHeight: CGFloat {
        if isIPhoneX {
            return 34
        }
        return 0
    }
    
    static var safeTabHeight: CGFloat {
        return safeAreaBottomHeight + 49.0
    }
    

}
