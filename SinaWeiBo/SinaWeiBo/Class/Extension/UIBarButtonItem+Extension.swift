//
//  UIBarButtonItem+Extension.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/16.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    // 构造方法 便利构造方法
    convenience init(imageName: String, target: AnyObject?, action: Selector) {
        let button = UIButton()
        
        button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        button.sizeToFit()
        
        // 点击事件
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        self.init(customView: button)
    }
    
    // 类方法
    class func createBarButtonItem(imageName: String) -> UIBarButtonItem{
        let button = UIButton()
        
        button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        button.sizeToFit() // 让控件自动适应大小
        
        return UIBarButtonItem(customView: button)
    }
}