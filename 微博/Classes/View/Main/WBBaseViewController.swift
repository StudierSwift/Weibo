//
//  WBBaseViewController.swift
//  微博
//
//  Created by IVT502 on 2017/2/8.
//  Copyright © 2017年 IVT. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    var tableView : UITableView?
    var refreshController: UIRefreshControl?
    var isPullUp = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadData()
    }
    ///mark 加载数据
    @objc func loadData() {
        
    }
    
    func pullupData() {
    
    }
}

///设置界面
extension WBBaseViewController {

    fileprivate func setUpUI(){
        setupTableView()
        setupBgColor()
    }
    
    
    private func setupBgColor(){
        view.backgroundColor = UIColor.init(red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1);
    }
    
    private func setupTableView(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView?.dataSource = self;
        tableView?.delegate = self;
        view.insertSubview(tableView!, belowSubview: (navigationController?.navigationBar)!)
        
        refreshController = UIRefreshControl()

//        let attachment = NSTextAttachment()
//        attachment.image = UIImage(named: "ren")
//        attachment.bounds = CGRect(x: 0, y: 0, width: (refreshController?.frame.height)!, height: (refreshController?.frame.height)!)
//        
//        let attStr = NSAttributedString(attachment: attachment)
        
//        refreshController?.attributedTitle = attStr
        refreshController?.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        tableView?.addSubview(refreshController!)
        refreshController?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
}

///数据源方法和代理方法
extension WBBaseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        
        if row < 0 || section < 0 {
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        if (row == count - 1) && !isPullUp {
            pullupData()
            
        } 
    }
}

