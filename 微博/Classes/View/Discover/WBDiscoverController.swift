//
//  WBDiscoverController.swift
//  微博
//
//  Created by IVT502 on 2017/2/14.
//  Copyright © 2017年 IVT. All rights reserved.
//

import UIKit

class WBDiscoverController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let db2 = WBDatabase.sharedDatabase
        let db3 = WBDatabase.sharedDatabase
        
        print(db2)
        print(db3)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
