//
//  AppDelegate.swift
//  微博
//
//  Created by IVT502 on 2017/2/8.
//  Copyright © 2017年 IVT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, JPUSHRegisterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = WBTabBarController()
        
        window?.makeKeyAndVisible()
        
//        setupNotifactionCertificate(launchOptions: launchOptions)
        
        return true
    }

    // 注册通知iOS8以上
    private func setupNotifactionCertificate(launchOptions: [UIApplicationLaunchOptionsKey: Any]?){
        
        let entity = JPUSHRegisterEntity()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue) |  Int(JPAuthorizationOptions.sound.rawValue) |  Int(JPAuthorizationOptions.badge.rawValue);
        
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        
        // 注册极光推送
        JPUSHService.setup(withOption: launchOptions, appKey: "a128db1b49773439c0ff9f8c", channel:"Publish channel" , apsForProduction: false);
        // 获取推送消息
        let remote = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? Dictionary<String,Any>;
        // 如果remote不为空，就代表应用在未打开的时候收到了推送消息
        if remote != nil {
            // 收到推送消息实现的方法
            self.perform(#selector(receivePush), with: remote, afterDelay: 1.0);
        }
        
        
//        let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//        UIApplication.shared.registerUserNotificationSettings(setting)
        
    }
    
    // 接收到推送实现的方法
   @objc private func receivePush(_ userInfo : Dictionary<String,Any>) {
        // 角标变0
        UIApplication.shared.applicationIconBadgeNumber = 0;
        // 剩下的根据需要自定义
//        self.tabBarVC?.selectedIndex = 0;
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName_ReceivePush), object: NotificationObject_Sueecess, userInfo: userInfo)
    }
    

    //mark --- JPUSHRegisterDelegate
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        let userInfo = response.notification.request.content.userInfo;
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo);
        }
        completionHandler();
////         应用打开的时候收到推送消息
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName_ReceivePush), object: NotificationObject_Sueecess, userInfo: userInfo)
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
    }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        JPUSHService.handleRemoteNotification(userInfo);
        completionHandler(UIBackgroundFetchResult.newData);
    }
    
    
    //注册apns失败
    //当注册失败时，触发此函数。
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("注册通知失败=========",error)
    }
    
    //注册apns成功
    //会接收来自苹果服务器给你返回的deviceToken，然后你需要将它添加到你本地的推送服务器上。（很重要，决定你的设备能不能接收到推送消息）。
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        JPUSHService.registerDeviceToken(deviceToken)
        
        let message = String(data: deviceToken, encoding: .utf8) ?? ""
        
        let alert = UIAlertView(title: "注册成功", message: message, delegate: nil, cancelButtonTitle: "确定")
        
        alert.show()
    }
    
    
    ///这个函数则是当设备接收到来自苹果推送服务器的消息时触发的，用来显示推送消息。
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("userInfo======",userInfo)
        
        let message = (userInfo["aps"] as? NSDictionary)?["alert"]
        
        
        let alertView = UIAlertView(title: "提示", message: message as! String?, delegate: nil, cancelButtonTitle: "确定")
        alertView.show()
        
    }
    
    
    
//    private func registerAppNotificationSettings(launchOptions:[UIApplicationLaunchOptionsKey: Any]?) {
//        if #available(iOS 10.0, *) {
//            let notifiCenter = UNUserNotificationCenter.current()
//            notifiCenter.delegate = self
//            let types = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
//            notifiCenter.requestAuthorization(options: types) { (flag, error) in
//                if flag {
//                    print("iOS request notification success")
//                }else{
//                    print(" iOS 10 request notification fail")
//                }
//            }
//        } else { //iOS8,iOS9registration
//            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(setting)
//        }
//        
//        DispatchQueue.main.async {
//            UIApplication.shared.registerForRemoteNotifications()
//            let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(userSettings)
//        }
//    }
//    
}

