//
//  WBDatabase.swift
//  微博
//
//  Created by IVT502 on 2017/3/17.
//  Copyright © 2017年 IVT. All rights reserved.
//

import UIKit

///数据库生成和销毁
class WBDatabase: NSObject {
    
    fileprivate lazy var filePath: String = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last)!.appending("/WBSqilite.db")
    fileprivate var dbq: FMDatabase?
    
    fileprivate override init() {}

    override class func initialize() {
        super.initialize()
        print("数据库初始化")
    }
}

///设置单例
extension WBDatabase {
    
    static var sharedDatabase: WBDatabase {
        struct Static{
            static let instace: WBDatabase = WBDatabase()
        }
        return Static.instace
    }
    
}

///增删改查
extension WBDatabase {
    class func saveData() {
        
    }
    
    class func deleteData() {
    
    }
    
    class func updataData() {
        
    }
    
    class func searchData() {
        
    }
}
