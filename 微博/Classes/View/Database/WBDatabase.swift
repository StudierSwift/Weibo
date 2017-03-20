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
    fileprivate var dbqueue: FMDatabaseQueue?
    
    fileprivate override init() {}

    override class func initialize() {
        super.initialize()
        print("\(WBDatabase.sharedDatabase.filePath)")
        WBDatabase.sharedDatabase.openDB()
    }
    
    private func openDB(){
        dbqueue = FMDatabaseQueue(path: filePath)
        
        dbqueue?.inDatabase({ (db) in
            guard let db = db else {
                return
            }
            if db.open() {
                print("打开数据库成功")
                self.creatTable(db: db)
            }else {
                print("打开数据库失败")
            }
            
        })
    }
    
    private func creatTable(db: FMDatabase){
        let sql = "CREATE TABLE IF NOT EXISTS WB_ZhuYe (title TEXT NOT NULL,subTitle TEXT NOT NULL,imageTItle TEXT)"
        
        do{
            try db.executeUpdate(sql, values: [])
            print("创建表成功")
        }catch{
            print(error)
        }
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
