//
//  WBHomeModel.swift
//  微博
//
//  Created by IVT502 on 2017/3/20.
//  Copyright © 2017年 IVT. All rights reserved.
//

import UIKit

class WBHomeModel: NSObject {
    
    var title: String?
    var subTitle: String?
    var imageTitle: String?
    
    init(dict: [String: String]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {
        super.init()
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
