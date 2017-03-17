//
//  WBHomeCell.swift
//  微博
//
//  Created by IVT502 on 2017/3/14.
//  Copyright © 2017年 IVT. All rights reserved.
//

import UIKit

protocol WBHomeCellDelegate {
    func homeCellDidSelectRowAt(dict:[String: String])
}

class WBHomeCell: UITableViewCell {
    
    var dataStr: String? {
        didSet{
            label.text = dataStr
        }
    }
    
    var dict: [String: String]? {
        didSet{
            label.text = dict?["title"]
            subLabel.text = dict?["subTitle"]
            guard let imageTitle: String = dict?["imageTitle"] else { return }
            imageview.image = UIImage(named: imageTitle)
        }
    }
    
    typealias editedBlock = ([String: String]) ->()
    
    lazy fileprivate var label: UILabel = UILabel()
    lazy fileprivate var subLabel: UILabel = UILabel()
    lazy fileprivate var imageview: UIImageView = UIImageView()
    lazy fileprivate var button: UIButton = UIButton(type: UIButtonType.contactAdd)
    lazy fileprivate var seperator: UIView = UIView()
    var delegate: WBHomeCellDelegate?
    var edited : editedBlock?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Mark -- 设置界面
extension WBHomeCell{
    fileprivate func setupUI(){
        self.selectionStyle = .none
        
        imageview.contentMode = .redraw
        contentView.addSubview(imageview)
        
//        label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 54))
        label.textAlignment = . left
        label.font = UIFont.systemFont(ofSize: 18)
        contentView.addSubview(label)
        
        subLabel.textAlignment = .left
        subLabel.font = UIFont.systemFont(ofSize: 15)
        subLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        contentView.addSubview(subLabel)
        
        button.addTarget(self, action: #selector(adited), for: .touchUpInside)
        contentView.addSubview(button)
        
//        seperator = UIView(frame: CGRect(x: 1, y: 54, width: UIScreen.main.bounds.width, height: 1))
        seperator.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        contentView.addSubview(seperator)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageview.frame = CGRect(x: 10, y: 5, width: self.frame.height - 11, height: self.frame.height - 11)
        label.frame = CGRect(x: imageview.frame.maxX + 5, y: 5, width: self.contentView.frame.width - imageview.frame.maxX - 10, height: 30)
        subLabel.frame = CGRect(x: label.frame.minX, y: label.frame.maxY, width: label.frame.width, height: self.contentView.frame.height - label.frame.height - 1)
        
        button.frame = CGRect(x: UIScreen.main.bounds.width - 40, y: (self.contentView.frame.height - 30) * 0.5, width: 30, height: 30)
        
        seperator.frame = CGRect(x: 0, y: self.contentView.frame.height - 1, width: UIScreen.main.bounds.width, height: 1)
    }
    
    
}

//Mark -- 设置数据
extension WBHomeCell{
    func cellForStr(cellStr: String?)  {
        if let tempStr: String = cellStr {
            label.text = tempStr
        }
    }
    
    func cellForDict(dict: [String: String]?) {
        guard let dict = dict,
            let imageTitle = dict["imageTitle"],
            let title = dict["title"],
            let subTitle = dict["subTitle"]
            else { return }
        label.text = title
        subLabel.text = subTitle
        imageview.image = UIImage(named: imageTitle)
        
    }
    
    class func cellID() -> String {
        return "homeCell"
    }
    
    class func cellHeight() -> CGFloat {
        return 80
    }
}

///私有方法
extension WBHomeCell{
    @objc fileprivate func adited(){
        guard let dict = dict
            else { return}
        delegate?.homeCellDidSelectRowAt(dict: dict)
        edited?(dict)
    }
}
