//
//  WBProfileController.swift
//  微博
//
//  Created by IVT502 on 2017/2/8.
//  Copyright © 2017年 IVT. All rights reserved.
//

import UIKit

class WBProfileController: WBBaseViewController {
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

///设置UI
extension WBProfileController{
    fileprivate func setupUI(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonClicked))
    }
}

///交互私有方法
extension WBProfileController {
    @objc  func editButtonClicked() {
        print("点击导航条按钮")
    }
}
