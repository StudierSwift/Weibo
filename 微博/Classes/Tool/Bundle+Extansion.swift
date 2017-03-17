//
//  Bundle+Extansion.swift
//  微博
//
//  Created by IVT502 on 2017/2/8.
//  Copyright © 2017年 IVT. All rights reserved.
//

import UIKit

extension Bundle{

    var namespace : String {
        return infoDictionary?["CFBundleExecutable"] as? String ?? ""
    }
    
    
}
