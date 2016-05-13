//
//  BaseTableViewController.swift
//  SinaWeiBo
//
//  Created by 何启亮 on 16/5/12.
//  Copyright © 2016年 HQL. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    
    // MARK: - 属性
    var isLogin: Bool = false
    
    override func viewDidLoad() {
        if isLogin{
            // 如果登陆了，就照常加载
            super.viewDidLoad()
        }else{
            // 如果没有登陆，则进入访客视图
            self.view = visitor
            visitor.delegate = self
            
            if self.isKindOfClass(HomeController) {
                visitor.startRotationAnimation()
            }else if self is MessageController{
                visitor.setupVisitorInfo("visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
            }else if self is DiscoveryController{
                visitor.setupVisitorInfo("visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
            }else if self is ProfileController{
                visitor.setupVisitorInfo("visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            }
            
            // 没有登录才设置导航栏
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(visitorViewDidClickRegister))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(visitorViewDidClickLogin))
        }
        
    }

    // MARK: - 懒加载
    lazy var visitor: visitorView = visitorView()

}
// MARK: - 协议
/**
 *  switf 中遵守协议有两种方式，一种是在class定义的时候，在父类后面加上“,协议名”，一种是扩展对象实现协议: 可以将一个协议对应的代码写在一起
 */
extension BaseTableViewController: visitorViewDelegate{
    // 实现协议方法
    // 登录
    func visitorViewDidClickLogin() {
        CZPrint(items: "登录")
    }
    // 注册
    func visitorViewDidClickRegister() {
        print("注册")
    }
    
}


