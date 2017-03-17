//
//  WBTabBarController.swift
//  微博
//
//  Created by IVT502 on 2017/2/8.
//  Copyright © 2017年 IVT. All rights reserved.
//

import UIKit

class WBTabBarController: UITabBarController {
    
    private lazy var addBtn = UIButton()
    
//MARK -- 循环引用
//    private lazy var addBtn: UIButton = {
//        var addBtn = UIButton()
//        let btnW = self.tabBar.bounds.width / CGFloat(self.childViewControllers.count)
//        let btnH = self.tabBar.bounds.height
//        let btnX = btnW * 2
//        let btnY: CGFloat = 0.0
//        
//        addBtn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
//        addBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
//        addBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
//        addBtn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: .normal)
//        addBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
//        return addBtn
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
        setupAddBtnProprety()
        setupAddButton(button: addBtn)
    }
    // 设置addbtn的属性
    private func setupAddBtnProprety(){
        let btnW = tabBar.bounds.width / CGFloat(childViewControllers.count)
        let btnH = self.tabBar.bounds.height
        let btnX = btnW * 2
        let btnY: CGFloat = 0.0
        addBtn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        addBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        addBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        addBtn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: .normal)
        addBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        addBtn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
    }
    
    @objc private func addBtnClicked(){
//        let vc = UIViewController()
//        vc.view.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        
//        self.present(vc, animated: true, completion: nil);
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
    }
}

extension WBTabBarController{

    fileprivate func setupChildControllers(){
        let array = [
            [
                "title":"主页",
                "normalImage":"tabbar_home",
                "selectedImage":"tabbar_home_selected",
                "clsName":"WBHomeController"
            ],
            [
                "title":"消息",
                "normalImage":"tabbar_message_center",
                "selectedImage":"tabbar_message_center_selected",
                "clsName":"WBMessageController"
            ],
            [
                "title":"",
                "normalImage":"",
                "selectedImage":"",
                "clsName":""
            ],
            [
                "title":"发现",
                "normalImage":"tabbar_discover",
                "selectedImage":"tabbar_discover_selected",
                "clsName":"WBDiscoverController"
            ],
            [
                "title":"我的",
                "normalImage":"tabbar_profile",
                "selectedImage":"tabbar_profile_selected",
                "clsName":"WBProfileController"
            ]
        ]
        
        var controllers : [UIViewController] = []
        
        for dict in array {
            controllers.append(setupChildViewControllers(dict: dict))
        }
        
        viewControllers = controllers
    }
    
    /// 标题：title 正常图片：nomalImage 选中图片：selectedImage 控制器：clsName
    private func setupChildViewControllers(dict: [String : String]) ->UIViewController{
        
        guard let title = dict["title"],
            let cName = dict["clsName"],
            let normalImage = dict["normalImage"],
            let selectedImage = dict["selectedImage"],
            let cls = NSClassFromString(Bundle.main.namespace + "." + cName) as? UIViewController.Type
            else {
                return UIViewController()
        }
        
        let vc = cls.init()
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: normalImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.purple], for: .highlighted)
        let nav = WBNavigationController(rootViewController: vc)
        
        return nav
    }
    
    fileprivate func setupAddButton(button: UIButton){
        tabBar.addSubview(button)
    }
}

