//
//  PHAsset+Extensions.swift
//  DrivingTour
//
//  Created by Zack on 2020/2/26.
//  Copyright © 2020 Zack. All rights reserved.
//

import Foundation
import MobileCoreServices


extension PHAsset {
    
  var isGIF: Bool {
    guard let resource = PHAssetResource.assetResources(for: self).first else {
        return false
    }
      // 通过统一类型标识符(uniform type identifier) UTI 来判断
    let uti = resource.uniformTypeIdentifier as CFString
    return UTTypeConformsTo(uti, kUTTypeGIF)
    
    // 或者通过文件名后缀来判断
//    return assetSource.originalFilename.hasSuffix("GIF")
  }
}
