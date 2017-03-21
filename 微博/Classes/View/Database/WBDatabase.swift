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
    var dbqueue: FMDatabaseQueue?
    
    ///初始化init必须私有化，不能让其他类调用
    fileprivate override init() {}
    ///类初始化自动调用
    override class func initialize() {
        super.initialize()
        WBDatabase.sharedDatabase.openDB()
    }
    ///打开数据库
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
    ///创建表
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
    class func saveData(model: WBHomeModel) {
        
        WBDatabase.sharedDatabase.dbqueue?.inTransaction({ (db, rollback) in
            
            let result = db?.executeUpdate("INSERT INTO WB_ZhuYe (title, subTitle, imageTitle) values (?,?,?)", withArgumentsIn: [
                model.title ?? "",
                model.subTitle ?? "",
                model.imageTitle ?? ""
                ])
            if (result == true){
                print("数据存储成功")
            }else{
                print("数据存储失败")
            }
        })
        
    }
    
    class func deleteData() {
    
    }
    
    class func updataData() {
        
    }
    
    class func searchData() -> [WBHomeModel] {
        var modelList: [WBHomeModel] = []
        
        WBDatabase.sharedDatabase.dbqueue?.inTransaction({ (db, rollBack) in
            let set: FMResultSet? = db?.executeQuery("SELECT * FROM WB_ZhuYe", withArgumentsIn: [])
            while (set?.next())!{
                let model: WBHomeModel = WBHomeModel()
                model.title = set?.string(forColumn: "title")
                model.subTitle = set?.string(forColumn: "subTitle")
                model.imageTitle = set?.string(forColumn: "imageTitle")
                modelList.append(model)
            }
        })
        
        return modelList
    }
}

///获取要操作的模型的属性名称和属性值
extension WBDatabase{
    fileprivate class func propertyList(model: NSObject) ->[String] {
        var count: UInt32 = 0
        let list = class_copyPropertyList(model.classForCoder, &count)
        var ptyList: [String] = []
        
        for i in 0..<Int(count) {
            guard let pty = list?[i],
                  let cName = property_getName(pty),
                  let name = String(utf8String: cName)
                
            else { continue }
            ptyList.append(name)
        }
        return ptyList
    }
    
    fileprivate class func proptyValueList(model: NSObject) -> [Any]{
        let allPropertys = propertyList(model: model)
        var valueList: [Any] = []
        
        for i in 0..<allPropertys.count {
            let va = model.value(forKey: allPropertys[i])
            valueList.append(va as Any)
        }
        return valueList
    }
}
