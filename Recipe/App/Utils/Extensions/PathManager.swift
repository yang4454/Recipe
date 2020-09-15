//
//  SaveDataDocumentPath.swift
//  ChildrenNet
//
//  Created by Zack on 2020/5/19.
//  Copyright © 2020 ZK. All rights reserved.
//

import Foundation

/// https://www.jianshu.com/p/fd7dded46cc2

struct PathManager {
    static func HomePath() -> String {
        return NSHomeDirectory()
    }
    
    static func DocumentsPath() -> String {
        return HomePath() + "/Documents"
    }
    
    static func LibraryPath() -> String {
        return HomePath() + "/Library"
    }
    
    static func tmpPath() -> String {
        return HomePath() + "/tmp"
    }
    
    static func PreferencesPath() -> String {
        return LibraryPath() + "/Preferences"
    }
    
    static func CachesPath() -> String {
        return LibraryPath() + "/Caches"
    }
}
